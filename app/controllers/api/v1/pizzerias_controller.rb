module Api
    module V1
        class PizzeriasController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show, :coordinates]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
            
            # Två alternativ:
            # - Presentera alla Pizzeriums (ev. med Limit och Offset).
            # - Presentera en Tags alla Pizzeriums.
            def index
                if params[:tag_id] != nil
                    if Tag.exists?(:id => params[:tag_id])
                        @tag = Tag.find(params[:tag_id])
                        @pizzeriaTags = PizzeriaTag.where(tag_id: params[:tag_id])
                        @pizzerias = Pizzerium.order('created_at').all
                        
                        render 'tagsPizzerias'
                    else
                        error404
                    end
                else
                    @pizzerias = Pizzerium.order('created_at DESC').all
                    
                    if params[:limit] != nil && params[:offset] != nil
                        @pizzerias = Pizzerium.order('created_at DESC').limit(params[:limit]).offset(params[:offset])
                    end
                    
                    render 'index'
                end
            end
            
            # Presentera en Pizzerium.
            def show
                if Pizzerium.exists?(:id => params[:id])
                    @pizzeria = Pizzerium.find(params[:id])
                    @position = Position.find(@pizzeria.position_id)
                    @creator = Creator.find(@pizzeria.creator_id)
                    
                    render 'show'
                else
                    error404
                end
            end
            
            # Presentera alla Pizzeriums i närheten av Position (koordinater).
            def coordinates
                if Position.exists?(:latitude => params[:latitude], :longitude => params[:longitude])
                    @position = Position.where(:latitude => params[:latitude], :longitude => params[:longitude]).first
                else
                    @position = Position.create(latitude: params[:latitude], longitude: params[:longitude])
                end
                
                @pizzerias = Pizzerium.all
                render 'coordinates'
            end
            
            # Skapar Pizzerium, Position, Creator och Tags.
            def create
                @position = Position.new(position_params[:position])
                @position.save
                @creator = Creator.new(creator_params[:creator])
                @creator.save
                @pizzeria = Pizzerium.new(name: pizzeria_params[:name], position_id: @position.id, creator_id: @creator.id)
        
                if @pizzeria.save
                    tags_params[:pizzeria][:tags].each do |t|
                        if !Tag.exists?(:name => t[:name])
                            tag = Tag.new(name: t[:name])
                            tag.save
                        else 
                            tag = Tag.where(name: t[:name]).first
                        end
                        
                        pt = PizzeriaTag.new(pizzeria_id: @pizzeria.id, tag_id: tag.id)
                        pt.save
                    end
                    @tags = Array.new
                    @pt = PizzeriaTag.where(pizzeria_id: @pizzeria.id)
                    @pt.each do |t|
                       @tags.push(Tag.find(t.tag_id)) 
                    end
                
                    render 'create'
                else
                    error400
                end
            end
            
            # Radera en Pizzerium och dess Position, Creator och PizzeriaTags.
            def destroy
                if Pizzerium.exists?(:id => params[:id])
                    pizzeria = Pizzerium.find(params[:id])
                    position = Position.find(pizzeria.position_id)
                    creator = Creator.find(pizzeria.creator_id)
                    PizzeriaTag.where(pizzeria_id: pizzeria.id).delete_all
                    creator.destroy
                    position.destroy
                    pizzeria.destroy
        
                    render 'delete'
                else
                    error400
                end
            end
            
            # Hämta parametrar till en Pizzerium.
            def pizzeria_params
                params.require(:pizzeria).permit(:name)
            end
            
            # Hämta parametrar till en Position.
            def position_params
                params.require(:pizzeria).permit(position: [ :latitude, :longitude ])
            end
            
            # Hämta parametrar till en Creator.
            def creator_params
                params.require(:pizzeria).permit(creator: [ :firstName, :lastName ])
            end
            
            # Hämta parametrar till flera Tags.
            def tags_params
                params.permit(pizzeria: [ { tags: :name } ])
            end
        end
    end
end

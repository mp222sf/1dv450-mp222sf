module Api
    module V1
        class PizzeriasController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show, :coordinates, :create, :destroy, :login, :isAuthorized]
            before_action :checkToken, :only => [:create, :destroy, :isAuthorized]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:login]
            skip_before_filter :verify_authenticity_token, :only => [:create, :destroy, :login, :isAuthorized]
            
            # Två alternativ:
            # - Presentera alla Pizzeriums (ev. med Limit och Offset).
            # - Presentera en Tags alla Pizzeriums.
            def index
                if params[:tag_id] != nil
                    if Tag.exists?(:id => params[:tag_id])
                        @tag = Tag.find(params[:tag_id])
                        @pizzeriaTags = PizzeriaTag.where(tag_id: params[:tag_id])
                        @pizzerias = Pizzerium.order('created_at').all
                        @positions = Position.all
                        @menus = Menu.all
                        @dishes = Dish.all
                        
                        render 'tagsPizzerias'
                    else
                        error404
                    end
                else
                    @pizzerias = Pizzerium.order('created_at DESC').all
                    @positions = Position.all
                    @menus = Menu.all
                    @dishes = Dish.all
                    
                    if number_or_nil(params[:limit]) != nil
                        @pizzerias = Pizzerium.order('created_at DESC').limit(params[:limit])
                        if number_or_nil(params[:offset]) != nil
                            @pizzerias = Pizzerium.order('created_at DESC').limit(params[:limit]).offset(params[:offset])
                        end
                    else 
                        if number_or_nil(params[:offset]) != nil
                            @pizzerias = Pizzerium.order('created_at DESC').offset(params[:offset])
                        end
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
                    @tags = Tag.all;
                    @pizzeriaTags = PizzeriaTag.where(pizzeria_id: params[:id])
                    
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
                if pizzeria_params != nil && position_params != nil && creator_params != nil && tags_params != nil
                    @position = Position.new(position_params[:position])
                    @position.save
                    if Creator.exists?(:firstName => creator_params[:creator][:firstName], :lastName => creator_params[:creator][:lastName])
                        @creator = Creator.where(firstName: creator_params[:creator][:firstName], lastName: creator_params[:creator][:lastName]).first
                    else
                        @creator = Creator.new(creator_params[:creator])
                        @creator.save
                    end
                    @pizzeria = Pizzerium.new(name: pizzeria_params[:name], position_id: @position.id, creator_id: @creator.id)
            
                    if @pizzeria.save
                        if tags_params[:pizzeria][:tags] != nil
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
                        end
                        @tags = Array.new
                        @pt = PizzeriaTag.where(pizzeria_id: @pizzeria.id)
                        @pt.each do |t|
                           @tags.push(Tag.find(t.tag_id)) 
                        end
                    
                        render 'create'
                    else
                        @message = "Pizzerian gick inte att skapa."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
                    error400
                end
            end
            
            # Radera en Pizzerium och dess Position, Creator och PizzeriaTags.
            def destroy
                if Pizzerium.exists?(:id => params[:id])
                    pizzeria = Pizzerium.find(params[:id])
                    position = Position.find(pizzeria.position_id)
                    menus = Menu.where(pizzeria_id: params[:id])

                    menus.each do |m|
                        Dish.where(menu_id: m.id).destroy_all
                    end
                    PizzeriaTag.where(pizzeria_id: pizzeria.id).delete_all
                    menus.destroy_all
                    position.destroy
                    pizzeria.destroy
        
                    render 'delete'
                else
                    @message = "Pizzerian gick inte att radera. Pizzerian existerar inte."
                    error400
                end
            end
            
            def login
                @encrypted_data = $crypt.encrypt_and_sign($basicUsername + ":" + $basicPassword)
            end
            
            def isAuthorized
            end
            
            # Hämta parametrar till en Pizzerium.
            def pizzeria_params
                begin
                    params.require(:pizzeria).permit(:name)
                rescue
                    nil
                end
            end
            
            # Hämta parametrar till en Position.
            def position_params
                begin
                    params.require(:pizzeria).permit(position: [ :address ])
                rescue
                    nil
                end
            end
            
            # Hämta parametrar till en Creator.
            def creator_params
                begin
                    params.require(:pizzeria).permit(creator: [ :firstName, :lastName ])
                rescue
                    nil
                end
            end
            
            # Hämta parametrar till flera Tags.
            def tags_params
                begin
                    params.permit(pizzeria: [ { tags: :name } ])
                rescue
                    nil
                end
            end
        end
    end
end

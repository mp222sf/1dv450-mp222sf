module Api
    module V1
        class TagsController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show, :create, :update, :destroy]
            before_action :checkToken, :only => [:create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
            
            # Två alternativ:
            # - Presentera alla Tags (ev. med Limit och Offset).
            # - Presentera en Pizzeriums alla Tags.
            def index
                if params[:pizzeria_id] != nil
                    if Pizzerium.exists?(:id => params[:pizzeria_id])
                        @pizzeria = Pizzerium.find(params[:pizzeria_id])
                        @tags = Tag.all
                        @pizzeriaTags = PizzeriaTag.where(pizzeria_id: params[:pizzeria_id])
                        render 'pizzeriaTags'
                    else 
                        error404
                    end
                else
                    @tags = Tag.all
                    render 'index'
                end
            end
            
            # Presentera en Tag.
            def show
                if Tag.exists?(:id => params[:id])
                    @tag = Tag.find(params[:id])
                    render 'show'
                else 
                    error404
                end
            end
            
            # Skapa en Tag.
            def create
                @tag = Tag.new(tag_params)
        
                if @tag.save
                    render 'create'
                else
                    error400
                end
            end
        
            # Uppdatera en Tag.
            def update
                if Tag.exists?(:id => params[:id])
                    
                    @tag = Tag.find(params[:id])
                    if @tag.update_attributes(tag_params)
                        render 'update'
                    else
                        error400
                    end
                else
                    error400
                end
            end
            
            # Radera en Tag.
            def destroy
                if Tag.exists?(:id => params[:id])
                    tag = Tag.find(params[:id])
                    tag.destroy
        
                    render 'delete'
                else
                    error400
                end
            end
            
            # Hämta parametrar till en Tag.
            def tag_params
                params.require(:tag).permit(:name)
            end
        end
    end
end
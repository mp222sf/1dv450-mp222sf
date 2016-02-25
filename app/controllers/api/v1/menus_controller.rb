module Api
    module V1
        class MenusController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:new, :create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:new, :create, :update, :destroy]
            
            # Två alternativ:
            # - Presentera alla Menus (ev. med Limit och Offset).
            # - Presentera en Pizzerias alla Menus.
            def index
                if params[:pizzeria_id] != nil
                    if Pizzerium.exists?(:id => params[:pizzeria_id])
                        @pizzeria = Pizzerium.find(params[:pizzeria_id])
                        @menus = Menu.where(pizzeria_id: params[:pizzeria_id])
                        @dishes = Dish.all
                        render 'pizzeriaMenus'
                    else
                        error404
                    end
                else
                    @menus = Menu.all
                    
                    if params[:limit] != nil && params[:offset] != nil
                        @menus = Menu.limit(params[:limit]).offset(params[:offset])
                    end
                    
                    render 'index'
                end
            end
            
            # Presentera en Menu.
            def show
                if Menu.exists?(:id => params[:id])
                    @menu = Menu.find(params[:id])
                    @pizzeria = Pizzerium.find(@menu.pizzeria_id)
                    @dishes = Dish.where(menu_id: params[:id])
                    
                    render 'show'
                else
                    error404
                end
            end
            
            # Skapa en Menu.
            def create
                @menu = Menu.new(menus_params)
        
                if @menu.save
                    render 'create'
                else
                    error400
                end
            end
            
            # Uppdatera en Menu.
            def update
                if Menu.exists?(:id => params[:id])
                    
                    @menu = Menu.find(params[:id])
                    if @menu.update_attributes(menus_params)
                        render 'update'
                    else
                        error400
                    end
                else
                    error400
                end
            end
            
            # Radera en Menu.
            def destroy
                if Menu.exists?(:id => params[:id])
                    menu = Menu.find(params[:id])
                    Dish.where(menu_id: menu.id).delete_all
                    menu.destroy
        
                    render 'delete'
                else
                    error400
                end
            end
            
            # Hämta parametrar till en Menu.
            def menus_params
                params.require(:menu).permit(:name, :pizzeria_id)
            end
        end
    end
end

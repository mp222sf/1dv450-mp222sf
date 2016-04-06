module Api
    module V1
        class MenusController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show, :create, :update, :destroy]
            before_action :checkToken, :only => [:create, :update, :destroy]
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
                    
                    if number_or_nil(params[:limit]) != nil
                        @menus = Menu.limit(params[:limit])
                        if number_or_nil(params[:offset]) != nil
                            @menus = Menu.limit(params[:limit]).offset(params[:offset])
                        end
                    else 
                        if number_or_nil(params[:offset]) != nil
                            @menus = Menu.offset(params[:offset])
                        end
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
                if menus_params != nil
                    @menu = Menu.new(menus_params)
                    
                    if Pizzerium.exists?(:id => @menu.pizzeria_id)
                        if @menu.save
                            render 'create'
                        else
                            @message = "Det gick inte att spara menyn."
                            error400
                        end        
                    else
                        @message = "Menyn gick inte att skapa. Pizzerian med ID:t " + @menu.pizzeria_id.to_s + " existerar inte."
                        error400
                    end
                else 
                    @message = "Du har angett fel parametrar."
                    error400
                end
            end
            
            # Uppdatera en Menu.
            def update
                if menus_params != nil
                    if Menu.exists?(:id => params[:id])
                        
                        @menu = Menu.find(params[:id])
                        if @menu.update_attributes(menus_params)
                            render 'update'
                        else
                            @message = "Det gick inte att uppdatera menyn."
                            error400
                        end
                    else
                        @message = "Menyn gick inte att uppdatera. Pizzerian med ID:t " + @menu.pizzeria_id.to_s + " existerar inte."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
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
                    @message = "Menyn gick inte att radera. Menyn existerar inte."
                    error400
                end
            end
            
            # Hämta parametrar till en Menu.
            def menus_params
                begin
                    params.require(:menu).permit(:name, :pizzeria_id)
                rescue
                    nil
                end
            end
        end
    end
end

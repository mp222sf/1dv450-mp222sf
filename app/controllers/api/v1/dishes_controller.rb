module Api
    module V1
        class DishesController < ApplicationController
            before_action :requireApiKey, :only => [:show, :create, :update, :destroy]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
            
            # Presentera en Position.
            def show
                if Dish.exists?(:id => params[:id])
                    @dish = Dish.find(params[:id])
                    render 'show'
                else
                    error404
                end
            end
            
            # Skapa en Dish.
            def create
                if dishes_params != nil
                    @dish = Dish.new(dishes_params)
                    
                    if Menu.exists?(:id => @dish.menu_id)
                        if @dish.save
                            render 'create'
                        else
                            @message = "Rätten gick inte att skapa."
                            error400
                        end     
                    else
                        @message = "Det finns ingen meny med Id: " + @dish.menu_id.to_s + "."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
                    error400
                end
            end
        
            # Uppdatera en Dish.
            def update
                if dishes_params != nil
                    if Dish.exists?(:id => params[:id])
                        
                        @dish = Dish.find(params[:id])
                        if @dish.update_attributes(dishes_params)
                            render 'update'
                        else
                            @message = "Rätten gick inte att uppdatera."
                            error400
                        end
                    else
                        @message = "Rätten gick inte att uppdatera. Rätten med ID:t " + @dish.id.to_s + " existerar inte."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
                    error400
                end
            end
            
            # Radera en Dish.
            def destroy
                if Dish.exists?(:id => params[:id])
                    dish = Dish.find(params[:id])
                    dish.destroy
        
                    render 'delete'
                else
                    @message = "Rätten gick inte att radera. Rätten existerar inte."
                    error400
                end
            end
            
            # Hämta parametrar till en Dish.
            def dishes_params
                begin
                    params.require(:dish).permit(:name, :ingredients, :price, :menu_id)
                rescue
                    nil
                end
            end
        end
    end
end

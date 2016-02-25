module Api
    module V1
        class DishesController < ApplicationController
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
            
            # Skapa en Dish.
            def create
                @dish = Dish.new(dishes_params)
        
                if @dish.save
                    render 'create'
                else
                    error400
                end
            end
        
            # Uppdatera en Dish.
            def update
                if Dish.exists?(:id => params[:id])
                    
                    @dish = Dish.find(params[:id])
                    if @dish.update_attributes(dishes_params)
                        render 'update'
                    else
                        error400
                    end
                else
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
                    error400
                end
            end
            
            # Hämta parametrar till en Dish.
            def dishes_params
                params.require(:dish).permit(:name, :ingredients, :price, :menu_id)
            end
        end
    end
end

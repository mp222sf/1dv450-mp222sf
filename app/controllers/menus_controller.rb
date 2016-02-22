class MenusController < ApplicationController
    
    def index
        
        if Pizzerium.exists?(:id => params[:pizzeria_id])
            @pizzeria = Pizzerium.find(params[:pizzeria_id])
            @menus = Menu.where(pizzeria_id: params[:pizzeria_id])
            @dishes = Dish.all
            
            render 'index.json.erb'
        else
            render 'shared/error.json.erb'
        end
    end
end

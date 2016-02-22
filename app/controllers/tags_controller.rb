class TagsController < ApplicationController
    
    def index
        if Pizzerium.exists?(:id => params[:pizzeria_id])
            @pizzeria = Pizzerium.find(params[:pizzeria_id])
            @tags = Tag.all
            @pizzeriaTags = PizzeriaTag.where(pizzeria_id: params[:pizzeria_id])
            render 'index.json.erb'
        else 
            render 'shared/error.json.erb'
        end
        
    end
end

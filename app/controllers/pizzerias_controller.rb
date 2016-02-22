class PizzeriasController < ApplicationController
    respond_to :json
    
    def index
        @pizzerias = Pizzerium.all
        
        render 'index.json.erb'
    end

    def show
        if Pizzerium.exists?(:id => params[:id])
            @pizzeria = Pizzerium.find(params[:id])
            @position = Position.find(@pizzeria.position_id)
            @creator = Creator.find(@pizzeria.creator_id)
            
            render 'show.json.erb'
        else
            render 'shared/error.json.erb'
        end
    end
    
    def coordinates
        if Position.exists?(:latitude => params[:latitude], :longitude => params[:longitude])
            @position = Position.where(:latitude => params[:latitude], :longitude => params[:longitude]).first
        else
            @position = Position.create(latitude: params[:latitude], longitude: params[:longitude])
        end
        
        @pizzerias = Pizzerium.all
        render 'coordinates.json.erb'
    end
end

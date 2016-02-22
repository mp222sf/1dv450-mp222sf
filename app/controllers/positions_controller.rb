class PositionsController < ApplicationController
    
    def index
        @positions = Position.all
        
        render 'index.json.erb'
    end
    
    def show
        if Position.exists?(:id => params[:id])
            @position = Position.find(params[:id])
            render 'show.json.erb'
        else
            render 'shared/error.json.erb'
        end
    end
end

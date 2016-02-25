module Api
    module V1
        class PositionsController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:new, :create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:new, :create, :update, :destroy]
            
            # Presentera alla Positions (ev. med Limit och Offset).
            def index
                @positions = Position.all
                
                if params[:limit] != nil && params[:offset] != nil
                    @positions = Position.limit(params[:limit]).offset(params[:offset])
                end

                render 'index'
            end
            
            # Presentera en Position.
            def show
                if Position.exists?(:id => params[:id])
                    @position = Position.find(params[:id])
                    render 'show'
                else
                    error404
                end
            end
            
            # Skapa en Position.
            def create
                @position = Position.new(positions_params)
        
                if @position.save
                    render 'create'
                else
                    error400
                end
            end
        
            # Uppdatera en Position.
            def update
                if Position.exists?(:id => params[:id])
                    
                    @position = Position.find(params[:id])
                    @position.address = nil
                    if @position.update_attributes(positions_params)
                        render 'update'
                    else
                        error400
                    end
                else
                    error400
                end
            end
            
            # Radera en Position.
            def destroy
                if Position.exists?(:id => params[:id])
                    position = Position.find(params[:id])
                    position.destroy
        
                    render 'delete'
                else
                    error400
                end
            end
            
            # Hämta parametrar till en Position.
            def positions_params
                params.require(:position).permit(:address, :latitude, :longitude)
            end
        end
    end
end
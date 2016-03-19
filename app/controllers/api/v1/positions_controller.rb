module Api
    module V1
        class PositionsController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:index, :show, :create, :update, :destroy]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:new, :create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:new, :create, :update, :destroy]
            
            # Presentera alla Positions (ev. med Limit och Offset).
            def index
                @positions = Position.all
                
                if number_or_nil(params[:limit]) != nil
                    @positions = Position.limit(params[:limit])
                    if number_or_nil(params[:offset]) != nil
                        @positions = Position.limit(params[:limit]).offset(params[:offset])
                    end
                else 
                    if number_or_nil(params[:offset]) != nil
                        @positions = Position.offset(params[:offset])
                    end
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
                    @message = "Positionen gick inte att skapa."
                    error400
                end
            end
        
            # Uppdatera en Position.
            def update
                if positions_params != nil
                    if Position.exists?(:id => params[:id])
                        
                        @position = Position.find(params[:id])
                        if @position.update_attributes(positions_params)
                            render 'update'
                        else
                            @message = "Positionen gick inte att uppdatera."
                            error400
                        end
                    else
                        @message = "Positionen gick inte att uppdatera. Positionen existerar inte."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
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
                    @message = "Positionen gick inte att radera."
                    error400
                end
            end
            
            # Hämta parametrar till en Position.
            def positions_params
                begin
                    params.require(:position).permit(:address, :latitude, :longitude)
                rescue
                    nil
                end
            end
        end
    end
end
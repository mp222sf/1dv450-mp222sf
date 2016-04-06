module Api
    module V1
        class CreatorController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:show, :create, :update, :destroy]
            before_action :checkToken, :only => [:create, :update, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]
            
            # Presentera en Creator.
            def show
                if Creator.exists?(:id => params[:id])
                    @creator = Creator.find(params[:id])
        
                    render 'show'
                else
                    error404
                end
            end
        
            # Skapa en Creator.
            def create
                @creator = Creator.new(creator_params)
        
                if @creator.save
                    render 'create'
                else
                    @message = "Skaparen gick inte att skapa."
                    error400
                end
            end
        
            # Uppdatera en Creator.
            def update
                if creator_params != nil
                    if Creator.exists?(:id => params[:id])
                        
                        @creator = Creator.find(params[:id])
                        if @creator.update_attributes(creator_params)
                            render 'update'
                        else
                            @message = "Skaparen gick inte att uppdatera."
                            error400
                        end
                    else
                        @message = "Skaparen gick inte att uppdatera. Skaparen med ID:t " + @creator.id.to_s + " existerar inte."
                        error400
                    end
                else
                    @message = "Du har angett fel parametrar."
                    error400
                end
            end
            
            # Radera en Creator.
            def destroy
                if Creator.exists?(:id => params[:id])
                    creator = Creator.find(params[:id])
                    creator.destroy
        
                    render 'delete'
                else
                    @message = "Skaparen gick inte att radera."
                    error400
                end
            end
            
            # Hämta parameterar till Creator.
            def creator_params
                begin
                    params.require(:creator).permit(:firstName, :lastName)
                rescue
                    nil
                end
            end
        end
    end
end

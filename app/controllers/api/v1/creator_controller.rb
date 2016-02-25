module Api
    module V1
        class CreatorController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:show]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:create, :update, :destroy]
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
                    error400
                end
            end
        
            # Uppdatera en Creator.
            def update
                if Creator.exists?(:id => params[:id])
                    
                    @creator = Creator.find(params[:id])
                    if @creator.update_attributes(creator_params)
                        render 'update'
                    else
                        error400
                    end
                else
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
                    error400
                end
            end
            
            # Hämta parameterar till Creator.
            def creator_params
                params.require(:creator).permit(:firstName, :lastName)
            end
        end
    end
end

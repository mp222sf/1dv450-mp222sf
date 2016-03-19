module Api
    module V1
        class PizzeriatagsController < ApplicationController
            before_action :requireApiKey, :headersLastModified, :only => [:create, :destroy]
            http_basic_authenticate_with name: $basicUsername, password: $basicPassword, :only => [:create, :destroy]
            skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]
            
            # Skapa en PizzeriaTag.
            def create
                @pizzeriaTag = PizzeriaTag.new(pizzeriaTag_params)
        
                if @pizzeriaTag.save
                    render 'create'
                else
                    @message = "Pizzeria-taggen gick inte att skapa."
                    error400
                end
            end
            
            # Radera en Position.
            def destroy
                if PizzeriaTag.exists?(:id => params[:id])
                    pizzeriaTag = PizzeriaTag.find(params[:id])
                    pizzeriaTag.destroy
        
                    render 'delete'
                else
                    @message = "Pizzeria-taggen gick inte att radera."
                    error400
                end
            end
            
            # Hämta parametrar till en PizzeriaTag.
            def pizzeriaTag_params
                begin
                    params.require(:pizzeriaTag).permit(:pizzeria_id, :tag_id)
                rescue
                    nil
                end
            end
        end
    end
end

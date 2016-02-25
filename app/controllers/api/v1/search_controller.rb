module Api
    module V1
        class SearchController < ApplicationController
            before_action :requireApiKey, :headersLastModified
            
            # Presentera Pizzeriums efter sökord.
            def search
                @search = Pizzerium.where("name like ?", "%#{params[:word]}%")
                render 'index'
            end
        end
    end
end

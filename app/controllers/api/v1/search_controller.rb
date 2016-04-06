module Api
    module V1
        class SearchController < ApplicationController
            before_action :requireApiKey, :headersLastModified
            
            # Presentera Pizzeriums efter sökord.
            def search
                @search = Pizzerium.where("lower(name) like ?", "%#{params[:word]}%")
                @positions = Position.all
                @menus = Menu.all
                @dishes = Dish.all
                render 'index'
            end
        end
    end
end

class ErrorController < ApplicationController
    def index
       render 'shared/error.json.erb', status: 404
    end
    
    def apikey
       render 'shared/errorApiKey.json.erb', status: 401
    end
end

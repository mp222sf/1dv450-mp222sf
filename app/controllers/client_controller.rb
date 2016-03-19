class ClientController < ApplicationController
    def index
    end
    
    def mainJS
        render 'main.js', layout: false
    end
end

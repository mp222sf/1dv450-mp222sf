class ApikeysController < ApplicationController
    before_action :requireLogin
    
    def index
        if Authentication.find(session[:authID]).rights == 1
            @keys = ApiKey.all
            @auth = Authentication.all
            render "indexAdmin"
        end
        @keys = ApiKey.where(authentication_id: session[:authID])
    end
    
    def new
        @apiKey = ApiKey.new
    end
    
    # Skapar en ny användare.
    def create
        @apiKey = ApiKey.create(apikey_params)
        @apiKey.authentication_id = session[:authID]
        getUniqueKey
        
        if @apiKey.save
            redirect_to apikeys_path
        else
            render :action => "new"
        end
    end
    
    def show
        redirect_to apikeys_path
    end
    
    def destroy
        auth = Authentication.find(session[:authID])
        key = ApiKey.find(params[:id])
        
        if auth != nil
            if auth.rights == 1
                key.destroy
            else
                if key.authentication_id == auth.id
                    key.destroy
                end
            end
        end
        redirect_to apikeys_path
    end
    
    # Skapar en unik API-nyckel
    private
    def getUniqueKey
        loop do
            isUnique = true
            @apiKey.key = SecureRandom.hex(20)
            allKeys = ApiKey.all
            
            allKeys.each do |k|
                if k == @apiKey.key
                   isUnique = false 
                end
            end
            
            break if isUnique == true
        end
    end
    
    # Binder parametrar till ApiKey-objekt.
    def apikey_params
       params.require(:api_key).permit(:appName, :appURL) 
    end
end

class ApikeysController < ApplicationController
    
    def index
        isLoggedIn

        @keys = ApiKey.where(authentication_id: session[:authID])
    end
    
    def new
        isLoggedIn
        
        @apiKey = ApiKey.new
    end
    
    # Skapar en ny användare.
    def create
        isLoggedIn
        
        @apiKey = ApiKey.create(apikey_params)
        @apiKey.authentication_id = session[:authID]
        getUniqueKey
        
        if @apiKey.save
            redirect_to apikeys_path
        else
            render :action => "new"
        end
    end
    
    def destroy
        isLoggedIn
        
        ApiKey.find(params[:id]).destroy
        redirect_to apikeys_path
    end
    
    # Skapar en unik API-nyckel
    private
    def getUniqueKey
        loop do
            isUnique = true
            @apiKey.key = Array.new(32){rand(36).to_s(36)}.join
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
    private
    def apikey_params
       params.require(:api_key).permit(:appName, :appURL) 
    end
    
    # Om användaren inte är inloggad omdirigeras hen till inloggningssidan.
    private
    def isLoggedIn
        if !session[:authID]
            redirect_to root_path
        end
    end
end

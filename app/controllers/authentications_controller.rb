class AuthenticationsController < ApplicationController
    def new
        isLoggedIn
        @auth = Authentication.new
    end
    
    # Skapar en ny användare.
    def create
        @auth = Authentication.create(authentication_params)
        @auth.rights = 2
        
        if @auth.save
            session[:authID] = @auth.id
            redirect_to apikeyShow_path
        else
            render :action => "new"
        end
    end
    
    # Binder parametrar till Authentication-objekt.
    private
    def authentication_params
       params.require(:authentication).permit(:username, :email, :password, :password_confirmation) 
    end
    
    # Om användaren inte är inloggad omdirigeras hen till inloggningssidan.
    private
    def isLoggedIn
        if session[:authID]
            redirect_to root_path
        end
    end
end

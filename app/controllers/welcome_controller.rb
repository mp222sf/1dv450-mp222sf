class WelcomeController < ApplicationController
    # Startsida.
    def index
        if loggedIn?
            @auth = currentAuth
            render 'indexLoggedIn'
        end
    end
    
    # Registreringsformulär.
    def new
        @auth = Authentication.new
    end
    
    # POST, inloggningsförsök.
    def login
        a = Authentication.find_by_username(params[:username])
        if a && a.authenticate(params[:password])
            session[:authID] = a.id
            redirect_to root_path
        else
            flash[:notice] = "Failed!"
            redirect_to root_path
        end
    end
    
    def account
        if loggedIn?
            @auth = currentAuth
        else
            redirect_to root_path
        end
    end
    
    # Utloggning. Tar bort session.
    def logout
        session[:authID] = nil;
        redirect_to root_path :notice => "Utloggad"
    end
end

class WelcomeController < ApplicationController
    
    # Startsida.
    def index
        isLoggedIn
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
    
    # Utloggning. Tar bort session.
    def logout
        session[:authID] = nil;
        redirect_to root_path :notice => "Utloggad"
    end
    
    # Om inloggad - omdirigeras till apikeysida.
    def isLoggedIn
        if session[:authID]
            @auth = Authentication.find(session[:authID])
            if @auth.rights == 1
                render 'indexLoggedInAdmin'
            else
                render 'indexLoggedIn'
            end
        end
    end
end

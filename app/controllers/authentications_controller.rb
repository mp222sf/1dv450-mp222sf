class AuthenticationsController < ApplicationController
    before_action :alreadyLoggedIn, :except => [:showAll, :destroy]
    before_action :requireLogin, :except => [:new, :create]
    
    def showAll
        if Authentication.find(session[:authID]).rights == 2
            redirect_to root_path
        end
        @auth = Authentication.all
    end
    
    def new
        @auth = Authentication.new
    end
    
    # Skapar en ny användare.
    def create
        @auth = Authentication.create(authentication_params)
        @auth.rights = 2
        
        if @auth.save
            session[:authID] = @auth.id
            redirect_to root_path
        else
            render :action => "new"
        end
    end
    
    def destroy
        auth = Authentication.find(session[:authID])
        userToDelete = Authentication.find(params[:id])
        userApiKeysToDelete = ApiKey.where(authentication_id: userToDelete.id)
        
        if auth != nil
            if auth.rights == 1
                userApiKeysToDelete.destroy_all
                userToDelete.destroy
            end
        end
        redirect_to showAll_path
    end
    
    # Binder parametrar till Authentication-objekt.
    private
    def authentication_params
       params.require(:authentication).permit(:username, :email, :password, :password_confirmation) 
    end
end

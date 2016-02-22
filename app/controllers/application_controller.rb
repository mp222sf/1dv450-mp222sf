require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Om användaren inte är inloggad omdirigeras hen till inloggningssidan.
  private
  helper_method :currentAuth, :logged_in?
  
  def currentAuth
    @currentAuth ||= Authentication.find(session[:authID]) if session[:authID]
  end
  
  def requireLogin
    if currentAuth.nil? then
        redirect_to root_path
    end
  end
  
  def loggedIn?
    currentAuth != nil
  end
  
  def alreadyLoggedIn
    if currentAuth != nil
          redirect_to root_path
    end
  end
end

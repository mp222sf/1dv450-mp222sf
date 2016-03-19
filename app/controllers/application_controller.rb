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
  
  def requireApiKey
    if !ApiKey.exists?(:key => params[:key])
      render 'shared/errorApiKey.json.erb', :status => :unauthorized
    else 
      @requiredApiKey = ApiKey.find_by_key(params[:key])
    end
  end
  
  def headersLastModified
    headers['Last-Modified'] = Time.now.httpdate
  end
  
  def error404
    render 'shared/error.json.erb', :status => :not_found
  end
  
  def error400
    render 'shared/errorCreate.json.erb', :status => :bad_request
  end
  
  def number_or_nil(string)
      num = string.to_i
      num if num.to_s == string
  end
  
  $basicUsername = 'admin'
  $basicPassword = 'secret'
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # User Session
  def current_user
    @current_user ||= CurrentUser.with_id(session[:user_id])
  end
  helper_method :current_user

  def login!(user)
    session[:user_id] = user.id
    @current_user = CurrentUser.new(user)
  end

  def authorize! &block
    raise AuthorizationError, "Forbidden" unless block.call
  end

  def admin_only!
    authorize! { current_user.admin? }
  end
end

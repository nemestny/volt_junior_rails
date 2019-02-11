class ApplicationController < ActionController::API

  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    puts '*'*7
    p request.format.html?
    puts '*'*7

    if request.format.html?
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
      render :login unless @current_user
    else
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
  end
end

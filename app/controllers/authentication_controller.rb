class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request


  def authenticate
    puts '-'*7
    p request.format
    puts '-'*7

    
    command = AuthenticateUser.call(params[:email], params[:password])

    if request.format.html?

        session[:user_id] = command.result[:user_id] if command.success?
        redirect_to root_path
    else     
      
      if command.success?
        render json: { auth_token: command.result[:token] }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end

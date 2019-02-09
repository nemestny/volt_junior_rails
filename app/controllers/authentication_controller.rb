class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request


  def authenticate
    puts '-'*7
    p request.format
    puts '-'*7

    
    command = AuthenticateUser.call(params[:email], params[:password])

    if request.format.html?

      if command.success?
        session[:user_id] = command.result[:user_id]
        redirect_to root_path
      else
        render :login
      end
    
    else     
      
      if command.success?
        render json: { auth_token: command.result[:token] }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end

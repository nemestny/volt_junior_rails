class Api::V1::UsersController < ApplicationController
  include ActionController::RequestForgeryProtection
  include ActionView::Layouts
  layout 'application'

  # skip_before_action :authenticate_request
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def edit
  end

  def update
    avatar = permit_params[:avatar]
    if avatar && avatar.size < 3.megabytes 
      @current_user.avatar.attach(avatar)
      @errors = nil
      redirect_to root_path
    elsif avatar
      @errors = 'Should be less than 3MB'
      render :edit
    else
      @errors = 'No file'
      render :edit
    end
  end

  private

  def permit_params
    params.permit(:avatar)
  end

end

class Api::V1::UsersController < ApplicationController
  include ActionController::RequestForgeryProtection
  include ActionView::Layouts
  layout 'application'

  # skip_before_action :authenticate_request
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def edit
  end

  def update
    @current_user.avatar.attach(permit_params[:avatar]) if permit_params[:avatar]
    p @current_user.avatar.attached?
    redirect_to root_path
  end

  private

  def permit_params
    params.permit(:avatar)
  end

end

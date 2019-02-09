class Api::V1::UsersController < ApplicationController
  include ActionController::RequestForgeryProtection

  # skip_before_action :authenticate_request
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def edit
  end

  def update
  end

end

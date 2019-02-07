class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def edit
    render layout: 'layouts/application'
  end

  def update
  end
end

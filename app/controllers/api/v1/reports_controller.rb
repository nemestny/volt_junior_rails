class Api::V1::ReportsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    case permit_params[:type]
    when 'by_author'
      ReportsGenerateJob.perform_later permit_params
      render json: {message: 'Report generation started'}
    else
      render json: {errors: 'No report type found' }
    end
  end

  private

  def permit_params
    params.permit(:type, :start_date, :end_date, :email, :format)
  end
end

class ReportsGenerateJob < ApplicationJob
  queue_as :default

  def perform(*params)
    start_date = params[0][:start_date] || Time.now
    end_date = params[0][:end_date] || Time.now
    email = params[0][:email] || 'nemestny@politeh.ru'


    # Do something later
  end
end

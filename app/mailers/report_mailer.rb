class ReportMailer < ApplicationMailer

  def report_mail
    @email = params[:email]
    @report_columns = params[:report_columns]
    @report_rows = params[:report_rows]
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    mail(to: @email, subject: "Report from #{@start_date} to #{@end_date}")
        # ReportMailer.with(report_columns: report.columns,
        #                report_rows: report.rows,
        #                email: email,
        #                start_date: start_date,
        #                end_date: end_date).report_mail.deliver_later
  end
end

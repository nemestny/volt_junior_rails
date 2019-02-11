class ReportsGenerateJob < ApplicationJob
  queue_as :default

  def perform(*params)
    start_date = params[0][:start_date] || (Time.now - 1.day)
    end_date = params[0][:end_date] || Time.now
    email = params[0][:email] || 'nemestny@politeh.ru'

    # report = User.connection.select_all("SELECT users.nickname, users.email, posts.posts_count, comments.comments_count FROM users
    #                                     INNER JOIN (SELECT user_id, COUNT(*) AS posts_count FROM posts
    #                                     WHERE posts.published_at BETWEEN '#{start_date}' AND '#{end_date}'
    #                                     GROUP BY user_id) AS posts ON users.id = posts.user_id
    #                                     INNER JOIN (SELECT user_id, COUNT(*) AS comments_count FROM comments
    #                                     WHERE comments.published_at BETWEEN '#{start_date}' AND '#{end_date}'
    #                                     GROUP BY user_id) AS comments ON users.id = comments.user_id
    #                                     ORDER BY ((10 * posts.posts_count)+comments.comments_count) DESC")
    time_range = start_date..end_date

    report = User.all.includes(:posts, :comments)
                      .where(posts: {published_at: time_range}, comments: {published_at: time_range})
                      .sort do |e1, e2|
                        (10*e2.posts.length + e2.comments.length) <=> (10*e1.posts.length + e1.comments.length) 
                      end

    report_columns = ['nickname', 'email', 'posts', 'comments']
    report_rows = []

    report.each do |row|
      report_rows << [row.nickname, row.email, row.posts.length, row.comments.length]
    end
    
    # p report_rows
    ReportMailer.with(report_columns: report_columns,
                       report_rows: report_rows,
                       email: email,
                       start_date: start_date,
                       end_date: end_date).report_mail.deliver_later
  end
end

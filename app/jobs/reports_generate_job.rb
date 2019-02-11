class ReportsGenerateJob < ApplicationJob
  queue_as :default

  def perform(*params)
    start_date = params[0][:start_date] || (Time.now - 1.day)
    end_date = params[0][:end_date] || Time.now
    email = params[0][:email] || 'nemestny@politeh.ru'

    report = User.connection.select_all("SELECT users.nickname, users.email, posts.posts_count, comments.comments_count FROM users
                                        INNER JOIN (SELECT user_id, COUNT(*) AS posts_count FROM posts
                                        WHERE posts.published_at BETWEEN '#{start_date}' AND '#{end_date}'
                                        GROUP BY user_id) AS posts ON users.id = posts.user_id
                                        INNER JOIN (SELECT user_id, COUNT(*) AS comments_count FROM comments
                                        WHERE comments.published_at BETWEEN '#{start_date}' AND '#{end_date}'
                                        GROUP BY user_id) AS comments ON users.id = comments.user_id")
    
  end
end

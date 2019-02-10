class ReportsGenerateJob < ApplicationJob
  queue_as :default

  def perform(*params)
    start_date = params[0][:start_date] || (Time.now.midnight - 1.day)
    end_date = params[0][:end_date] || Time.now.midnight
    email = params[0][:email] || 'nemestny@politeh.ru'

    time_range = start_date..end_date
    users = User
            .left_outer_joins(:posts)
            .left_outer_joins(:comments)
            .where(posts: {published_at: time_range}, comments: {published_at: time_range})
            .distinct
            .select('users.nickname, users.email, COUNT(posts.*) AS posts_count, COUNT(comments.*) AS comments_count')
            .group('users.id')
            .group('users.id')
    users.each do |user|
      puts "- #{user.nickname} - #{user.email} - posts: #{user.posts_count} - comments: #{user.comments_count}"
    end
    # Do something later
  end
end

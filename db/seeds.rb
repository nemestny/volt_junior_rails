
def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

10.times do
  User.create(email: FFaker::Internet.email,
              nickname: FFaker::Internet.user_name,
              password: FFaker::Internet.password )
end

100.times do
  User.all.sample.posts.create(title: FFaker::HipsterIpsum.phrase,
                                body: FFaker::HipsterIpsum.paragraph,
                                published_at: rand_time(7.days.ago))
end

1000.times do
  User.all.sample.comments.create(body: FFaker::HipsterIpsum.paragraph,
                                  published_at: rand_time(7.days.ago))
end

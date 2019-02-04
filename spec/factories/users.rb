FactoryBot.define do
  factory :user, class: User do
    email { FFaker::Internet.email }
    nickname { FFaker::Internet.user_name}
    password { FFaker::Internet.password }
  end
end
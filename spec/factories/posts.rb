FactoryBot.define do
  factory :post, class: Post do
    title { FFaker::HipsterIpsum.phrase }
    body { FFaker::HipsterIpsum.paragraph}
    published_at {Time.now}
    association :user, factory: :user, strategy: :build
  end
end


FactoryBot.define do
  factory :post, class: Post do
    title { FFaker::HipsterIpsum.phrase }
    body { FFaker::HipsterIpsum.paragraph}
    association :user, factory: :user, strategy: :build
  end
end


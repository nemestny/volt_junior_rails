class Post < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :user

  validates :title, :body,  presence: true
end

class Post < ApplicationRecord
  validates :user_id, presence: true

  acts_as_likeable

  belongs_to :user

  # def get_likers_count
  #   likers(User).count
  # end
end

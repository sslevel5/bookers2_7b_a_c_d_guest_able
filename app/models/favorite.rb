class Favorite < ApplicationRecord
  include Notifiable
  belongs_to :user
  belongs_to :book
  has_one :notification, as: :notifiable, dependent: :destroy #追記

  validates :user_id, uniqueness: {scope: :book_id}

  after_create do
    create_notification(user_id: book.user_id)
  end

end

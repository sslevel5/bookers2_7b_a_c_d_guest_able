class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: {scope: :book_id}

  def get_book_week_favorite_count
    favorite_week_start = Date.today.beginning_of_day - 6.days
    favorite_week_end = Date.today.end_of_day

    self.favorites.where(created_at: favorite_week_start..favorite_week_end).count
  end


end

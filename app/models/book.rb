class Book < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy #追記

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def get_book_week_favorite_count
    favorite_week_start = Date.today.beginning_of_day - 6.days
    favorite_week_end = Date.today.end_of_day

    self.favorites.where(created_at: favorite_week_start..favorite_week_end).count
  end

  has_many :read_counts, dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

  validates :tag, presence: true

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end


end

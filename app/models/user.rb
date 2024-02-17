class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def get_today_book_count
    self.books.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).count
  end

  def get_yesterday_book_count
    self.books.where(created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day).count
  end

  def get_2days_ago_book_count
    four_days_ago_start = Date.today.beginning_of_day - 2.days
    four_days_ago_end = Date.today.end_of_day - 2.days

    self.books.where(created_at: four_days_ago_start..four_days_ago_end).count
  end

  def get_3days_ago_book_count
    four_days_ago_start = Date.today.beginning_of_day - 3.days
    four_days_ago_end = Date.today.end_of_day - 3.days

    self.books.where(created_at: four_days_ago_start..four_days_ago_end).count
  end

  def get_4days_ago_book_count
    four_days_ago_start = Date.today.beginning_of_day - 4.days
    four_days_ago_end = Date.today.end_of_day - 4.days

    self.books.where(created_at: four_days_ago_start..four_days_ago_end).count
  end

  def get_5days_ago_book_count
    four_days_ago_start = Date.today.beginning_of_day - 5.days
    four_days_ago_end = Date.today.end_of_day - 5.days

    self.books.where(created_at: four_days_ago_start..four_days_ago_end).count
  end

  def get_6days_ago_book_count
    four_days_ago_start = Date.today.beginning_of_day - 6.days
    four_days_ago_end = Date.today.end_of_day - 6.days

    self.books.where(created_at: four_days_ago_start..four_days_ago_end).count
  end







  def get_book_week_post_count
    past_week_start = Date.today.beginning_of_day - 6.days
    past_week_end = Date.today.end_of_day

    self.books.where(created_at: past_week_start..past_week_end).count
  end

  def get_book_last_week_post_count
    past_week_start = Date.today.beginning_of_day - 14.days
    past_week_end = Date.today.end_of_day - 7.days

    self.books.where(created_at: past_week_start..past_week_end).count
  end

end

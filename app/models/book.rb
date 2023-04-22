class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  is_impressionable counter_cache: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(star: :desc)}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Time.zone.now.all_week) }
  scope :created_last_week, -> { where(created_at: 1.week.ago.all_week ) }
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE ?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def self.search(search_word)
    @books = Book.where("tag LIKE ?", "#{search_word}")
  end
  
end
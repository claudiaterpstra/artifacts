class Course < ApplicationRecord
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user
  has_many :course_reviews, dependent: :destroy
  has_many :lectures, dependent: :destroy
  has_many :artworks, through: :lectures

  has_many :students, through: :participations, source: :user

  has_attachment :photo

  validates :name, presence: :true
  validates :category, presence: :true
  validates :description, presence: :true
  validates :price_pennies, presence: :true

  def average_rating
    if course_reviews.count > 0
      rating_array = []
      course_reviews.each do |review|
        rating_array << review.rating.to_f
      end
      total = rating_array.inject(:+)
      average_rating = total / course_reviews.count
      average_rating.ceil
    else
      average_rating = 0
    end
  end

end

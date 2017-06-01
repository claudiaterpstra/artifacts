class Course < ApplicationRecord
  belongs_to :user
  has_many :participations
  has_many :participants, through: :participations, source: :user

  has_attachment :photo
  validates :name, presence: :true
  validates :category, presence: :true
  validates :description, presence: :true
  validates :price, presence: :true
end

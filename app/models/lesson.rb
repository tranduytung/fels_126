class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 150}
end

class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  
  validates :content, presence: true, length: {maximum: 150}
end

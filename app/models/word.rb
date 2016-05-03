class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  
  validates :content, presence: true, length: {maximum: 150}

  def correct_answer
    answers.find_by word_id: id ,is_correct: true
  end
end

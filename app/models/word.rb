class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, limit: 4
  
  validates :content, presence: true, length: {maximum: 150}

  def correct_answer
    answers.find_by word_id: id ,is_correct: true
  end

end

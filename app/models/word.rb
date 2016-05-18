class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
  before_save :check_correct_answers, :check_answers_count
  scope :not_learned, ->user_id{where "id NOT IN (SELECT word_id FROM results
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", user_id}
  scope :random, ->{order"RANDOM()"}
  scope :learned, ->user_id{where "id IN (SELECT word_id FROM results
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", user_id}
  scope :all_word, ->user_id{}
  validates :content, presence: true, length: {maximum: 150}

  def correct_answer
    answers.find_by word_id: id ,is_correct: true
  end

  private

  def check_correct_answers
    correct_answer_count = self.answers.select{|answer| answer.is_correct}.size
    unless correct_answer_count == 1
      errors.add :base, I18n.t("message.should_have_a_correct_answer")
      return false
    end
  end

  def check_answers_count
    answers_count = self.answers.size
    unless (answers_count >= 1 && answers_count <= 4)
      errors.add :base, I18n.t("message.check_count_ansewer")
      return false
    end
  end
end

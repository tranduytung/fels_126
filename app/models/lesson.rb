class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  scope :public_by, ->user_id{where user_id: user_id}
  validate :check_words_size
  before_create :create_words

  def point
    self.results.select{|result|
      result.answer.present? && result.answer.is_correct}.size
  end

  private
  def create_words
    self.words = self.category.words.order("RANDOM()")
      .limit Settings.lesson.limit_words
  end

  def check_words_size
    @words = self.category.words
    if @words.size < Settings.lesson.limit_words
      errors.add :base, I18n.t("message.not_enough_word")
    end
  end
end

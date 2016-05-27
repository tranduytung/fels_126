class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  scope :public_by, ->user_id{where user_id: user_id}
  validate :check_words_size
  before_create :create_words
  before_update :create_activity_learned_lesson
  before_destroy :delete_activity

  def point
    self.results.select{|result|
      result.answer.present? && result.answer.is_correct}.size
  end

  def answered_numbers
    self.results.select{|result| result.answer.present?}.size
  end

  private
  def create_words
    self.words = self.category.words.not_learned(self.user).random
      .limit Settings.lesson.limit_words
  end

  def check_words_size
    @words = self.category.words.not_learned self.user
    if @words.size < Settings.lesson.limit_words
      errors.add :base, I18n.t("message.not_enough_word")
    end
  end

  def create_activity_learned_lesson
    Activity.create! action_type: :learned_lesson, user_id: self.user.id, 
      object_id: self.id
  end

  def delete_activity
      Activity.where(object_id: self.id, action_type: 2).each do |activity|
        activity.delete
    end
  end
end

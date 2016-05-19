class Activity < ActiveRecord::Base
  belongs_to :user
  validates :action_type, presence: true
  scope :all_activity, ->user_id{where "user_id IN (SELECT id
    FROM users WHERE id = :user_id or id IN (SELECT followed_id
    FROM relationships WHERE follower_id = :user_id))", user_id: user_id}

  def object
    @object = User.find_by id: self.object_id if
      self.action_type == Settings.activity.actions.follow ||
      self.action_type == Settings.activity.actions.unfollow
    @object = Lesson.find_by id: self.object_id if
      self.action_type == Settings.activity.actions.learned_lesson
    return @object
  end

  def action
    return I18n.t("action.follow") if
      self.action_type == Settings.activity.actions.follow
    return I18n.t("action.unfollow") if
      self.action_type == Settings.activity.actions.unfollow
    return I18n.t("action.learned_lesson") if
      self.action_type == Settings.activity.actions.learned_lesson
  end
end

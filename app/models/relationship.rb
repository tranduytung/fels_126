class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  before_save :create_activity_follow
  before_destroy :create_activity_unfollow

  private
  def create_activity_follow
    Activity.create! action_type: :follow, user_id: follower.id, 
      object_id: followed.id
  end

  def create_activity_unfollow
    Activity.create! action_type: :unfollow, user_id: follower.id, 
      object_id: followed.id
  end
end

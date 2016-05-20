class Activity < ActiveRecord::Base
  belongs_to :user
  enum action_type: {follow: 0, unfollow: 1, learned_lesson: 2}
  validates :object_id, presence: true
  scope :all_activity, ->user_id{where "user_id IN (SELECT id
    FROM users WHERE id = :user_id or id IN (SELECT followed_id
    FROM relationships WHERE follower_id = :user_id))", user_id: user_id}
end

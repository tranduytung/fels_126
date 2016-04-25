class Activity < ActiveRecord::Base
  belongs_to :user
  
  validates :action, presence: true, length: {maximum: 150}
end

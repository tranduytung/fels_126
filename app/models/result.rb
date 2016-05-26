class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer
  scope :order_result, ->{order(id: :ASC)}
end

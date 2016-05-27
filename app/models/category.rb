class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :content, presence: true, length: {maximum: 1500},
    uniqueness: {case_sensitive: false}
end

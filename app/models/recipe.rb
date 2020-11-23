class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimim: 5, maximum: 500 }
end
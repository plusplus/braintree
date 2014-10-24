class Pledge < ActiveRecord::Base
  validates :amount, numericality: true, presence: true
  validates :name, presence: true
end

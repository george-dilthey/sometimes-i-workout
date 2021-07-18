class Workout < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user
  has_and_belongs_to_many :segments

  validates :name, :date, :type, :distance, :elapsed_time, :public, presence: true

  def public?
    self.public
  end

end

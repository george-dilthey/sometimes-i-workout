class Workout < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user

  def public?
    self.public
  end
end

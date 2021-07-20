class Workout < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user
  has_and_belongs_to_many :segments

  validates :name, :date, :type, :distance, :elapsed_time, presence: true
  accepts_nested_attributes_for :segments

  before_create do
    self.polyline ? self.map = self.create_map : self.map = 'https://source.unsplash.com/random/1000x400?bike'
  end

  def public?
    self.public
  end

  def create_map
    polyline = URI.encode_www_form_component(self.polyline)
    url = "https://api.mapbox.com/styles/v1/gdilthey/ckef3rtzc0omw19nti733kki1/static/path-2+f44-1(#{polyline})/auto/1000x400?access_token=#{ENV["MAPBOX_ACCESS_TOKEN"]}"
  end

end

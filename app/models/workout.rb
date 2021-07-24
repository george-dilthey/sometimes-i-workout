class Workout < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user
  has_and_belongs_to_many :segments

  validates :name, :date, :type, :distance, :elapsed_time, presence: true
  validates :type, inclusion: {in: %w(Ride Run)}
  accepts_nested_attributes_for :segments

  scope :is_public, -> { where(public: true) }
  scope :order_by_date, -> {order(date: :desc)}
  scope :order_by_stars, -> {order(stars: :desc)}
  scope :search, -> (name){where("name LIKE ?", "%#{name}%")}


  before_create do
    self.polyline ? self.map = self.create_map : self.map = 'https://source.unsplash.com/random/1000x400?bike'
  end

  def create_map
    polyline = URI.encode_www_form_component(self.polyline)
    url = "https://api.mapbox.com/styles/v1/gdilthey/ckef3rtzc0omw19nti733kki1/static/path-2+f44-1(#{polyline})/auto/1000x400?access_token=#{ENV["MAPBOX_ACCESS_TOKEN"]}"
  end

  def add_star
    self.stars += 1
  end

end

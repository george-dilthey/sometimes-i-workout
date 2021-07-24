class Segment < ApplicationRecord
    has_and_belongs_to_many :workouts
    has_many :users, through: :workouts

    scope :search, -> (name){where("name LIKE ?", "%#{name}%")}

    def create_map
        polyline = URI.encode_www_form_component(self.polyline)
        url = "https://api.mapbox.com/styles/v1/gdilthey/ckef3rtzc0omw19nti733kki1/static/path-2+f44-1(#{polyline})/auto/1000x400?access_token=#{ENV["MAPBOX_ACCESS_TOKEN"]}"
    end

end

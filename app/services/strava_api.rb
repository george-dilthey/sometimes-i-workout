class StravaApi

    attr_accessor :client, :user

    def initialize(user_info)
        @client = Strava::Api::Client.new(
            access_token: user_info["credentials"]["token"]
          )
        @user = User.find_or_create_from_strava(user_info)
    end

    def get_activities
        activities = @client.athlete_activities
    end

    def get_segment_efforts(activity)
        segment_efforts = activity.segment_efforts
    end

    def get_segment(segment_effort)
        segment = segment_effort.segment
    end 

    def create_workouts
      self.get_activities.each do |a|
        if a.trainer == false
          Workout.find_or_create_by(id: a.id) do |workout|
            workout.name = a.name
            workout.date = a.start_date
            workout.distance = a.distance_in_miles
            workout.type = a.type
            workout.public = true
            workout.user_id = @user.id
            workout.elapsed_time = a.elapsed_time
            workout.polyline = a.map.summary_polyline
          end
        end
      end
    end 

    def create_segments
      self.get_activities.each do |a|
        if a.trainer == false
          activity = @client.activity(a.id)
          get_segment_efforts(activity).each do |se|
            segment = get_segment(se)
            Segment.find_or_create_by(id: segment.id) do |s|
              s.name = segment.name
              s.distance = segment.distance_in_miles
            end
            Workout.find_by_id(a.id).segments << Segment.find_by_id(segment.id)
          end
        end
      end
    end




end
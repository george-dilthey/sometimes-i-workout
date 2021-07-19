class StravaWorkouts

    def self.get_workouts(user_info)
      client = Strava::Api::Client.new(
        access_token: user_info["credentials"]["token"]
      )

      activities = client.athlete_activities
    end


    def self.create_workouts(user_info)
      get_workouts(user_info).each do |a|
        if a.trainer == false
          Workout.find_or_create_by(id: a.id) do |workout|
            workout.name = a.name
            workout.date = a.start_date
            workout.distance = a.distance_in_miles
            workout.type = a.type
            workout.public = true
            workout.user_id = user_info.uid
            workout.elapsed_time = a.elapsed_time
            workout.polyline = a.map.summary_polyline
          end
        end
      end
    end

    def self.create_segments(user_info)
      client = Strava::Api::Client.new(
        access_token: user_info["credentials"]["token"]
      )
      get_workouts(user_info).each do |a|
        if a.trainer == false
          activity = client.activity(a.id)
          segment_efforts = activity.segment_efforts
          segment_efforts.each do |se|
            segment = se.segment
            byebug
            Segment.find_or_create_by(id: segment.id) do |s|
              s.name = segment.name
              s.distance = segment.distance
            end
            Workout.find_by_id(a.id).segments << Segment.find_by_id(segment.id)
          end
        end
      end
    end

end
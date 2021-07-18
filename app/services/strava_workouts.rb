class StravaWorkouts

    def self.get_workouts(user_info)
      client = Strava::Api::Client.new(
        access_token: user_info["credentials"]["token"]
      )

      activities = client.athlete_activities

      activities.each do |a|
        Workout.find_or_create_by(id: a.id) do |workout|
          workout.name = a.name
          workout.date = a.start_date
          workout.distance = a.distance_in_miles
          workout.type = a.type
          workout.public = true
          workout.user_id = user_info.uid
          workout.elapsed_time = a.elapsed_time
        end
      end
    end

end
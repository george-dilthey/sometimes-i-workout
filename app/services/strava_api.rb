class StravaApi

    attr_accessor :client, :user

    def initialize(access_token)
        @client = Strava::Api::Client.new(
            access_token: access_token
          )
        
        @user = User.find_or_create_from_strava(@client.athlete)
    end

    def get_activities
        activities = @client.athlete_activities(per_page: 100)
    end

    def get_segment_efforts_from_activity(activity)
        segment_efforts = activity.segment_efforts
    end

    def get_segment_from_effort(segment_effort)
        segment = segment_effort.segment
    end 

    def create_workouts
      self.get_activities.each do |a|
        if a.segment_efforts != nil
          Workout.find_or_create_by(id: a.id) do |workout|
            workout.name = a.name
            workout.date = a.start_date
            workout.distance = a.distance_in_miles
            workout.type = a.type
            workout.public = true
            workout.user_id = @client.athlete.id
            workout.elapsed_time = a.elapsed_time
            workout.polyline = a.map.summary_polyline
          end
        end
      end
    end 

    def create_segments
      self.get_activities.each do |a|     
        if a.segment_efforts != nil
          activity = @client.activity(a.id)
          get_segment_efforts_from_activity(activity).each do |se|
            segment = get_segment_from_effort(se)
            Segment.find_or_create_by(id: segment.id) do |s|
              s.name = segment.name
              s.distance = segment.distance_in_miles
            end
            Workout.find_by_id(a.id).segments << Segment.find_by_id(segment.id)
          end
        end
      end
    end

    def update_segment_from_id(id)
      strava_segment = @client.segment(id)
      segment = Segment.find_by_id(id)
      segment.polyline = strava_segment.map.polyline
      segment.map = segment.create_map
      segment.save
    end

end
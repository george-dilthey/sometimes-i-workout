class StravaApi

    attr_accessor :client, :user, :activities

    def initialize(access_token)
        @client = Strava::Api::Client.new(
            access_token: access_token
          )
        @user = User.find_or_create_from_strava(@client.athlete)
    end

    def get_activities
      @activities = client.athlete_activities(per_page: 30).select {|a| a.trainer == false}.map { |a| client.activity(a.id)}
    end

    def create_workouts_and_segments
      self.get_activities
      @activities.each do |a|
        if a.segment_efforts != nil && a.trainer == false
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
          a.segment_efforts.each do |se|
            segment = se.segment
            Segment.find_or_create_by(id: segment.id) do |s|
              s.name = segment.name
              s.distance = segment.distance_in_miles
            end
            Workout.find_by_id(a.id).segments << Segment.find_by_id(segment.id)
          end
        end
      end
    end 

    def create_segments
      @activities.each do |a|     
        if a.segment_efforts != nil && a.trainer = false
          a.segment_efforts.each do |se|
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
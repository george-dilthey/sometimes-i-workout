class SegmentsController < ApplicationController

    def index
        @segments = User.find_by_id(params[:user_id]).segments
    end

    def show
        StravaApi.new(access_token).update_segment_from_id(params[:id]) if access_token
        @segment = Segment.find_by_id(params[:id])
    end
    
end

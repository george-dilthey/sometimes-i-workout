class SegmentsController < ApplicationController

    def index
        @segments = User.find_by_id(params[:user_id]).segments
    end

    def index
        @params = params.permit(:search).to_h
        if params[:user_id]
            require_login_and_user
            @user = User.find_by_id(params[:user_id])
            @segments = @user.segments.search(params[:search])
            render :user_index 
        else 
            @segments = Segment.all.search(params[:search])
        end
    end

    def show
        StravaApi.new(access_token).update_segment_from_id(params[:id]) if access_token
        @segment = Segment.find_by_id(params[:id])
    end
    
end

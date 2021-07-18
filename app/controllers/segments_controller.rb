class SegmentsController < ApplicationController

    def index
        @segments = User.find_by_id(params[:user_id]).segments
    end
    
end

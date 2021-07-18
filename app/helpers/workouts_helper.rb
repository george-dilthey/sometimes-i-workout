module WorkoutsHelper

    def display_date(date)
        date.strftime("%A, %B %e @ %I:%M%p")
    end

    def display_distance(dist)
        dist.round(2)
    end

end

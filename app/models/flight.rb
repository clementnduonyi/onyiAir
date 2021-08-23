class Flight < ApplicationRecord
    belongs_to :start, class_name: :Airport
    belongs_to :finish, class_name: :Airport
    has_many :bookings
    has_many :passengers, through: :bookings


    def durations
        "%dh %02dm" % flight_duration.divmod(60)
    end

    def flights_time
        departure_time.strftime("%I:%M %P")
    end
end


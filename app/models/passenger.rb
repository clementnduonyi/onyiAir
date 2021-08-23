class Passenger < ApplicationRecord
    belongs_to :booking
    has_many :bookings, through: :booking, source: "flight"
end

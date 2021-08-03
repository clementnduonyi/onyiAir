class Airport < ApplicationRecord
    has_many :departures, class_name: :Flight, foreign_key: :start_id, dependent: :destroy
    has_many :arrivals, class_name: :Flight, foreign_key: :finish_id, dependent: :destroy
end

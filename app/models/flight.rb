class Flight < ApplicationRecord
    belongs_to :start, class_name: :Airport
    belongs_to :finish, class_name: :Airport
end

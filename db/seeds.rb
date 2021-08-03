# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tables = ActiveRecord::Base.connection.tables - ['schema_migrations']

tables.each do |table|
  ActiveRecord::Base.connection.execute "DELETE FROM `#{table}`"
  ActiveRecord::Base.connection.execute "DELETE FROM sqlite_sequence WHERE name='#{table}'"
end


airports = []
airports[0] = Airport.create(code: 'SAN', town: "San Diego, SA")
airports[1] = Airport.create(code: 'PIT', town: "Pittsburgh, PI")
airports[2] = Airport.create(code: 'DTW', town: "Detroit, DT")
airports[3] = Airport.create(code: 'JFK', town: "New York, NY")
airports[4] = Airport.create(code: 'SFO', town: "San Francisco, SF")
airports[5] = Airport.create(code: 'ORD', town: "Chicago, CH")
airports[6] = Airport.create(code: 'SLC', town: "Salt Lake City, SL")
airports[7] = Airport.create(code: 'DFW', town: "Dallas, DA")
airports[8] = Airport.create(code: 'SEA', town: "Seatle, SE")
airports[9] = Airport.create(code: 'BOS', town: "Boston, BO")


def flights_duration(start_airport, finish_airport)
  DURATIONS[start_airport][finish_airport] || DURATIONS[finish_airport][start_airport]
end


def random_time 
  Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
end

Date.new(2021, 10, 1)..(Date.new(2021, 10, 31)).each |date|
    airports.each do |start_airport|
        airports.each do |finish_airport|
            if start_airport == finish_airport
                next
            else
                3.times do |flight|
                    flight = Flight.create!(departure_date: date,
                                            departure_time: random_time,
                                            start_airport: start_airport,
                                            finish_airport: finish_airport,
                                            flight_duration: flights_duration(start_airport.code, finish_airport.code))
                end
            end
        end
    end
end

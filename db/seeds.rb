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

DURATIONS = {
  'SAN' => {
    'DTW' => 252,
    'JFK' => 304,
    'SFO' => 103,
    'ORD' => 254,
    'SLC' => 111,
    'DFW' => 182,
    'SEA' => 175,
    'BOS' => 308,
    'PIT' => 247
  },
  'DTW' => {
    'JFK' => 86,
    'SFO' => 284,
    'ORD' => 57,
    'SLC' => 195,
    'DFW' => 137,
    'SEA' => 245,
    'BOS' => 111,
    'PIT' => 53
  },
  'JFK' => {
    'SFO' => 320,
    'ORD' => 106,
    'SLC' => 251,
    'DFW' => 151,
    'SEA' => 301,
    'BOS' => 51,
    'PIT' => 68
  },
  'SFO' => {
    'ORD' => 238,
    'SLC' => 109,
    'DFW' => 194,
    'SEA' => 102,
    'BOS' => 334,
    'PIT' => 284
  },
  'ORD' => {
    'SLC' => 169,
    'DFW' => 116,
    'SEA' => 183,
    'BOS' => 121,
    'PIT' => 82
  },
  'SLC' => {
    'DFW' => 139,
    'SEA' => 104,
    'BOS' => 285,
    'PIT' => 206
  },
  'DFW' => {
    'SEA' => 207,
    'BOS' => 202,
    'PIT' => 147
  },
  'SEA' => {
    'BOS' => 310,
    'PIT' => 270
  },
  'BOS' => {
    'PIT' => 92
  },
  'PIT' => {}
}


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


def flights_duration(start, finish)
  DURATIONS[start][finish] || DURATIONS[finish][start]
end


def random_time 
  Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
end

Date.new(2021, 10, 1).upto(Date.new(2021, 10, 31)).each do |date|
    airports.each do |start|
        airports.each do |finish|
            next if start == finish
            3.times {Flight.create(departure_date: date,
                                   departure_time: random_time,
                                   start: start,
                                   finish: finish,
                                   flight_duration: flights_duration(start.code, finish.code))
            }
                
        end
    end
end

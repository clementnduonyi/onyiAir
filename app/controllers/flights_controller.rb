class FlightsController < ApplicationController

    def new
        @flight = Flight.new
    end

    def index
        @flight = Flight.new
        @flights = Flight.all
        @airports = Airport.all.map {|airport|[airport.code, airport.id]}
        @flight_schedule = Flight.all.map {|flight_date| [flight_date.departure_date, flight_date.departure_date ] }.uniq
        @passengers = [[1,1],[2,2], [3,3], [4,4]]
        if params[:flight]
            @res = Flight.where(start_id: params[:flight][:start_id],
                                finish_id: params[:flight][:finish_id],
                                departure_date: params[:flight][:departure_date]).to_a
        end
    end


    private

    def flight_params
        params.require(:flight).permit(:start_id, :finish_id, :departure_date, :departure_time, :flight_duration, :passengers)
    end

end
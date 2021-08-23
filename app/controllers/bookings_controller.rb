class BookingsController < ApplicationController

    def new
        @booking = Booking.new
        params[:passengers].to_i.times { @booking.passengers.build }
        @flight = Flight.find(params[:flight_id])
    end

    
    def create
        @booking = Booking.new(booking_params)
        if @booking.save
            flash[:notice] = "Booking succesfull"
            PassengerMailer.with(booking_id: @booking.id).thank_you_email.deliver_now
            redirect_to @booking
        else
            render "new"
        end
       
    end

     def show
        @booking = Booking.find(params[:id])
        @flight = @booking.flight
    end

    

    def index
        redirect_to root_path
    end


    private

    def booking_params
        params.require(:booking).permit(:passenger_id, :flight_id, passengers_attributes: [:id, :name, :email])

    end

    

end
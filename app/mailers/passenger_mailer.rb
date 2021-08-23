class PassengerMailer < ApplicationMailer
    
    def thank_you_email
        @booking = Booking.find(params[:booking_id])
        @url = booking_url(@booking)
        mail(to: @booking.passengers.pluck(:email), subject: "Thank you for booking on our site.")
    end
end

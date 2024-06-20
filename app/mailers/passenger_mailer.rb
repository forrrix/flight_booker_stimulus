class PassengerMailer < ApplicationMailer
  default from: 'notifications@FlightBooker.com'

  def booking_email
    @booking = params[:booking]
    @url  = 'http://localhost:3000/'
    @booking.passengers.each do |passenger|
      @user = passenger
      mail(to: @user.email, subject: 'Your flight have been booked!')
    end
  end
end

class BookingsController < ApplicationController

  def new
      #puts "booking new begin  : #{@booking.inspect}"
      @flights = params[:flight]
      #puts "@flights in bookings new : #{@flights.inspect}"
      #puts "booking Params flight: #{params[:flight]}"
      @pass = params[:flight]["passengers"].to_i
      #puts "@pass : #{@pass.inspect}"
      @flight = Flight.find_by(id: @flights[:selected_flight_id])
      puts "@flights in bookings new : #{@flights.inspect}"
      @booking = Booking.new
      @booking.passengers.build
  end

  def create
    puts "booking params : #{booking_params}"
    #@booking = Booking.new(booking_params)
    #@bookingpassengersb = @booking.passengers.build
    #puts "booking new end  : #{@bookingpassengersb.inspect}"
    #puts "booking.passengers : #{@booking.passengers.inspect}"
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
      PassengerMailer.with(booking: @booking, flight: @flight).booking_email.deliver_now
    else
      puts @booking.errors.full_messages
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end


  private
  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :_destroy, :name, :email])
  end
end

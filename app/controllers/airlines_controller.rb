class AirlinesController < ApplicationController
    def show
        @airline = Airline.find(params[:id])
        @passengers_and_flights = Passenger.adult(@airline.id)
    end
end
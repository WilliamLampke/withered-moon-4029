class FlightPassengersController < ApplicationController
    def destroy 
        FlightPassenger.destroy(params[:id])
        redirect_to "/flights"
    end
end
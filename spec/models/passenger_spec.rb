require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it { should have_many(:flight_passengers) }
    it { should have_many(:flights).through(:flight_passengers) }
  end
  before :each do
    @airline1 = Airline.create!(name: 'American Airlines')
    
    @flight1 = Flight.create!(number: 1, departure_city: 'Charlotte', arrival_city: 'Colorado', airline_id: @airline1.id)
    @flight2 = Flight.create!(number: 2, departure_city: 'Atlanta', arrival_city: 'New York City', airline_id: @airline1.id)
    @flight3 = Flight.create!(number: 3, departure_city: 'Los Angeles', arrival_city: 'DC', airline_id: @airline1.id)

    @passenger1 = Passenger.create!(name: 'William', age: 23)
    @passenger2 = Passenger.create!(name: 'Joseph', age: 26)
    @passenger3 = Passenger.create!(name: 'Daniel', age: 35)

    @passenger4 = Passenger.create!(name: 'Goomba1', age: 1)
    @passenger5 = Passenger.create!(name: 'Goomba2', age: 2)
    @passenger6 = Passenger.create!(name: 'Goomba3', age: 3)

    @fp1 = FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger2.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger3.id)

    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger4.id)
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger5.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger6.id)
  end
  describe 'adult' do

    it 'joins and only allows passengers over 18' do
      FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger1.id)
      expect(Passenger.adult.length).to eq(3)
    end
  end
end

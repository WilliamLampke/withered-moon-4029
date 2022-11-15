require 'rails_helper'

RSpec.describe 'Index' do
    before :each do
        @airline1 = Airline.create!(name: 'American Airlines')
        
        @flight1 = Flight.create!(number: 1, departure_city: 'Charlotte', arrival_city: 'Colorado', airline_id: @airline1.id)
        @flight2 = Flight.create!(number: 2, departure_city: 'Atlanta', arrival_city: 'New York City', airline_id: @airline1.id)
        @flight3 = Flight.create!(number: 3, departure_city: 'Los Angeles', arrival_city: 'DC', airline_id: @airline1.id)

        @passenger1 = Passenger.create!(name: 'William', age: 23)
        @passenger2 = Passenger.create!(name: 'Joseph', age: 26)
        @passenger3 = Passenger.create!(name: 'Daniel', age: 35)

        FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
        FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger2.id)
        FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger3.id)

    end
    it "I see a list of all flight numbers
    And next to each flight number I see the name of the Airline of that flight
    And under each flight number I see the names of all that flight's passengers" do
    visit "/flights"
    save_and_open_page

    expect(page).to have_content("Flight Number: 1")
    expect(page).to have_content("Flight Number: 2")
    expect(page).to have_content("Flight Number: 3")
    
    expect(page).to have_content('Airline: American Airlines')

    expect(page).to have_content('William')
    expect(page).to have_content('Joseph')
    expect(page).to have_content('Daniel')

    end

end

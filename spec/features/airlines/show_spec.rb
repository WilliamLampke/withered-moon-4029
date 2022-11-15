require 'rails_helper'

RSpec.describe 'Show' do
  before :each do
    @airline1 = Airline.create!(name: 'American Airlines')

    @flight1 = Flight.create!(number: 1, departure_city: 'Charlotte', arrival_city: 'Colorado',
                              airline_id: @airline1.id)
    @flight2 = Flight.create!(number: 2, departure_city: 'Atlanta', arrival_city: 'New York City',
                              airline_id: @airline1.id)
    @flight3 = Flight.create!(number: 3, departure_city: 'Los Angeles', arrival_city: 'DC',
                              airline_id: @airline1.id)

    @passenger1 = Passenger.create!(name: 'William', age: 23)
    @passenger2 = Passenger.create!(name: 'Joseph', age: 26)
    @passenger3 = Passenger.create!(name: 'Daniel', age: 35)

    @fp1 = FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger2.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger3.id)

    @passenger4 = Passenger.create!(name: 'Goomba1', age: 1)
    @passenger5 = Passenger.create!(name: 'Goomba2', age: 2)
    @passenger6 = Passenger.create!(name: 'Goomba3', age: 3)

    FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger4.id)
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger5.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger6.id)

  end

  it "Then I see a list of passengers that have flights on that airline
    And I see that this list is unique (no duplicate passengers)
    And I see that this list only includes adult passengers
    (Note: an adult is anyone with age greater than or equal to 18)" do
    
    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger1.id)
    
    visit "/airlines/#{@airline1.id}"
    
    expect(page).to have_content('William').once
    expect(page).to have_content('Joseph').once
    expect(page).to have_content('Daniel').once
    
    expect(page).to_not have_content('Goomba1')
    expect(page).to_not have_content('Goomba2')
    expect(page).to_not have_content('Goomba3')
    
  end
  describe 'extension' do
    it 'Then I see that the list of adult passengers is sorted
    by the number of flights each passenger has taken on the airline from most to least' do

    FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger1.id)
    FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger2.id)

    visit "/airlines/#{@airline1.id}"
    save_and_open_page
    expect("William, trips: 3").to appear_before("Joseph, trips: 2")
    expect("Joseph, trips: 2").to appear_before("Daniel, trips: 1")
    end
  end
 end

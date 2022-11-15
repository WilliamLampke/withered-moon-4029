class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers

  def self.adult(airline)
    select(:name, :id)
    .where('passengers.age >= ?', '18')
    .joins(:flights)
    .where(flights: { airline_id: airline})
    .group(:id, :name)
    .order("count_id DESC")
    .count(:id)
  end
end

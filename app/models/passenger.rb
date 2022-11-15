class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers

  def self.adult
    select(:name, :id)
    .where('passengers.age >= ?', '18')
    .joins(:flights)
    .group(:id, :name)
    .order("count_id DESC")
    .count(:id)
  end
end

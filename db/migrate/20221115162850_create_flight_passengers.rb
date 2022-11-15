class CreateFlightPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_passengers do |t|
      t.bigint :flight_id
      t.bigint :passenger_id
    end
  end
end

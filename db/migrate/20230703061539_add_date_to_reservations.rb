class AddDateToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :date, :date
  end
end

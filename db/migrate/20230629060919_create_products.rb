class AddProductIdsToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :product_ids, :string, array: true, default: []
  end
end

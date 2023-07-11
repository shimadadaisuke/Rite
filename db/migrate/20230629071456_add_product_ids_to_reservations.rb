class AddProductIdsToReservations < ActiveRecord::Migration[6.0]
  def up
    add_column :reservations, :product_ids, :integer, array: true, default: []
  end

  def down
    remove_column :reservations, :product_ids
  end
end

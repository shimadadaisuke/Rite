class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.date :date
      t.string :event

      t.timestamps
    end
  end
end

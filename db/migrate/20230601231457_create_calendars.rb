class CreateCalendars < ActiveRecord::Migration[6.0]
  def up
    unless table_exists?(:calendars)
      create_table :calendars do |t|
        t.datetime :date
        t.string :event
        # 他のカラムも追加可能

        t.timestamps
      end
    end
  end

  def down
    drop_table :calendars
  end
end

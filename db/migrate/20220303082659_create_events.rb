class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string "event_type" # Camp, Kids Night Out, Party, Pop'n'Play
      t.string "title"
      t.text "description"

      t.datetime "gb_datetime"
      t.integer "gb_duration"
      t.string "gb_registration_link"
      t.money "gb_price"

      t.datetime "fol_datetime"
      t.integer "fol_duration"
      t.string "fol_registration_link"
      t.money "fol_price"

      t.datetime "sac_datetime"
      t.integer "sac_duration"
      t.string "sac_registration_link"
      t.money "sac_price"

      t.timestamps
    end
  end
end

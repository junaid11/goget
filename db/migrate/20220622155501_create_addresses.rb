class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address, null: false
      t.decimal :longitude, null: false
      t.decimal :latitude, null: false
      t.timestamps
    end
  end
end

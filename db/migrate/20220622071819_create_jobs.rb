class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.integer :pickup_address_id, foreign_key: true, null: false
      t.integer :drop_address_id, foreign_key: true, null: false
      t.integer :executed_by, foreign_key: true
      t.integer :created_by, foreign_key: true, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end

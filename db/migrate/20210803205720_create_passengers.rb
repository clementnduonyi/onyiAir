class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :email
      t.bigint :booking_id

      t.timestamps
    end
    add_index :passengers, :booking_id
  end
end

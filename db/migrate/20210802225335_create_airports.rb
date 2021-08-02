class CreateAirports < ActiveRecord::Migration[6.1]
  def change
    create_table :airports do |t|
      t.string :code
      t.string :town

      t.timestamps
    end
  end
end

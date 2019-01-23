class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :location
      t.string :latitude
      t.string :longtitude
      t.text :image

      t.timestamps null: false
    end
  end
end

class CreateShiros < ActiveRecord::Migration
  def change
    create_table :shiros do |t|
      t.string :name
      t.string :hurigana
      t.integer :eria
      t.integer :city
      t.decimal :latitude, precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.timestamps null: false
    end
  end
end

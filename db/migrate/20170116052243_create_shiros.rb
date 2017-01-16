class CreateShiros < ActiveRecord::Migration
  def change
    create_table :shiros do |t|
      t.string :name
      t.string :hurigana
      t.integer :eria
      t.integer :city
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end

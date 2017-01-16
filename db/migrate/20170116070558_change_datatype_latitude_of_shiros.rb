class ChangeDatatypeLatitudeOfShiros < ActiveRecord::Migration
  def change
    change_column :shiros, :latitude, :string
  end
end

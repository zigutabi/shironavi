class ChangeDatatypeLongitudeOfShiros < ActiveRecord::Migration
  def change
    change_column :shiros, :longitude, :string
  end
end

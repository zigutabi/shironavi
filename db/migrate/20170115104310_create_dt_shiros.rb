class CreateDtShiros < ActiveRecord::Migration
  def change
    create_table :dt_shiros do |t|
      t.string  :nm_shiro
      t.string  :nm_shiro_kana
      t.integer :cd_chiku
      t.integer :cd_ken
      t.text    :tx_address
      t.float   :gm_lat
      t.float   :gm_lng
      t.timestamps null: false
    end
  end
end

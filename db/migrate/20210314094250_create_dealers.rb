class CreateDealers < ActiveRecord::Migration[6.1]
  def change
    create_table :dealers do |t|
      t.integer :sf_id, index: true, null: false, unique: true
      t.string :category, null: false
      t.string :name, null: false
      t.float :longitude
      t.float :latitude
      t.timestamps
    end
  end
end

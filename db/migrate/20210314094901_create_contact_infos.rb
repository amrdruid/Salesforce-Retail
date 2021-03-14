class CreateContactInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_infos do |t|
      t.string :street
      t.string :city
      t.string :zip
      t.string :country
      t.string :state
      t.string :phone
      t.references :dealers, foreign_key: true, null: false
      t.timestamps
    end
  end
end

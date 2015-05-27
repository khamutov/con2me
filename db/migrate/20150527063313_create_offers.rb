class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :category
      t.decimal :price
      t.text :desc
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end

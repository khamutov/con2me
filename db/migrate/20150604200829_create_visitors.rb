class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :os
      t.string :browser
      t.datetime :date
      t.integer :cookie
      t.string :source

      t.timestamps
    end
  end
end

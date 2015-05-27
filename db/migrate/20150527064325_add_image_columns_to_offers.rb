class AddImageColumnsToOffers < ActiveRecord::Migration
  def up
    add_attachment :offers, :image
  end

  def down
    remove_attachment :offers, :image
  end
end

class AddIndexToAdsUrl < ActiveRecord::Migration
  def change
	  add_index :ads, :url
  end
end

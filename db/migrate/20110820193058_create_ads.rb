class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :server
      t.text :text
      t.string :url
      t.boolean :review

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end

class CreateRegionSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :region_subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end

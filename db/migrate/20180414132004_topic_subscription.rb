class TopicSubscription < ActiveRecord::Migration[5.1]
  def change
    create_table :topic_subscriptions do |t|
      t.references :user, foreign_key: true
      t.string :topic_id

      t.timestamps
    end
    add_index :topic_subscriptions, :topic_id
  end
end

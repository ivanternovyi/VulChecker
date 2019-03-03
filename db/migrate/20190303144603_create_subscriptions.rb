class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :telegram_id
      t.string :name
      t.string :user_id

      t.timestamps
    end
  end
end

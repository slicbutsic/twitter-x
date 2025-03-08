class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :following, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end

    add_index :follows, [:follower_id, :following_id], unique: true
  end
end

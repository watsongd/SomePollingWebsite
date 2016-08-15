class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :ip
      t.integer :poll_id

      t.timestamps
    end
    add_index :votes, :ip
  end
end

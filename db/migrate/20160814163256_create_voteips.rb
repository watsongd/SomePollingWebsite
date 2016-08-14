class CreateVoteips < ActiveRecord::Migration[5.0]
  def change
    create_table :voteips do |t|
      t.integer :ip_address
      t.integer :poll_id

      t.timestamps
    end
    add_index :voteips, :poll_id
  end
end

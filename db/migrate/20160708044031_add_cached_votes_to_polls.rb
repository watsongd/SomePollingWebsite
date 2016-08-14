class AddCachedVotesToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :cached_total_votes, :integer, default: 0
    add_index :polls, :cached_total_votes
  end
end

class AddCachedVotesToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :cached_votes, :integer, default: 0
  end
end

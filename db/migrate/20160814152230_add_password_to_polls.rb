class AddPasswordToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :password, :string
  end
end

class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :title
      t.text :options
      t.boolean :public

      t.timestamps
    end
  end
end

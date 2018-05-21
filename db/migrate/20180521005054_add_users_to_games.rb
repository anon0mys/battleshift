class AddUsersToGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :player_1
    remove_column :games, :player_2
    change_table :games do |t|
      t.belongs_to :player_1, foreign_key: { to_table: :users }
      t.belongs_to :player_2, foreign_key: { to_table: :users }
    end
  end
end

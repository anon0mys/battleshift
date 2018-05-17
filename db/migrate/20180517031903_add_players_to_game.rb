class AddPlayersToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1, :integer
    add_column :games, :player_2, :integer
  end
end

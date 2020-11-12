class RemoveFavoritesCountFromRestaurants < ActiveRecord::Migration[6.0]
  def change
    remove_column :restaurants, :favorites_count
  end
end

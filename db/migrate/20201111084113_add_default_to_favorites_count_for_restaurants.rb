class AddDefaultToFavoritesCountForRestaurants < ActiveRecord::Migration[6.0]
  def change
    change_column_default :restaurants, :favorites_count, 0
  end
end

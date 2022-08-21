class AddTitleToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :title, :string
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :image

      t.timestamps
    end
  end
end

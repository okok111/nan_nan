class AddExtraToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :price, :string
    add_column :posts, :spice, :string
    add_column :posts, :curry, :string
    add_column :posts, :nann, :string
    add_column :posts, :drink, :string
    add_column :posts, :image1, :string
    add_column :posts, :image2, :string
  end
end

class AddImage2AndImage3ToParties < ActiveRecord::Migration
  def change
    add_column :parties, :image2, :string
    add_column :parties, :image3, :string
  end
end

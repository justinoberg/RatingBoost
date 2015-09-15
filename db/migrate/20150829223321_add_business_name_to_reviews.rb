class AddBusinessNameToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :business_name, :string
  end
end

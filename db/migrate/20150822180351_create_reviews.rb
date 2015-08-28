class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end

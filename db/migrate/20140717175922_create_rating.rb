class CreateRating < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end

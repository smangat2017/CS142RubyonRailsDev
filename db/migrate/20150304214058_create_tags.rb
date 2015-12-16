class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.integer :user_id
    	t.integer :photo_id
    	t.integer :height
    	t.integer :width
    	t.integer :y_coord
    	t.integer :x_coord
     	t.timestamps
    end
  end
end

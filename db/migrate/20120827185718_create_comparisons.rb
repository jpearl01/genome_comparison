class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end

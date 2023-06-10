class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.date :visit_day, null: false
      t.string :spot, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.float :review, null: false
      
      t.timestamps
    end
  end
end

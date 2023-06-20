class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.date :visit_day
      t.string :spot
      t.string :title, null: false
      t.text :text
      t.float :rate
      
      t.timestamps
    end
  end
end

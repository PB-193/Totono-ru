class CreateContentTags < ActiveRecord::Migration[6.1]
  def change
    create_table :content_tags do |t|
      t.references :content, foreign_key: true
      t.references :tag, foreign_key: true
      
      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :content_tags, [:content_id, :tag_id], unique: true
  end
end

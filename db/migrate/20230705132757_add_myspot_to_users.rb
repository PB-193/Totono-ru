class AddMyspotToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :myspot, :string
  end
end

class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :encryted_password, :string
  end
end

class MakeForeignKeyColumns < ActiveRecord::Migration
  def change
    add_column :books, :library_id, :integer

    add_column :books, :patron_id, :integer

    add_column :staff_members, :library_id, :integer
  end
end

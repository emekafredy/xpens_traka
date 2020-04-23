class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :incomes, :image, :file
    rename_column :expenses, :image, :file
  end
end

class AddImageToExpense < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :image, :string
  end
end

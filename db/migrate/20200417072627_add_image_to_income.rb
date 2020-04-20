class AddImageToIncome < ActiveRecord::Migration[6.0]
  def change
    add_column :incomes, :image, :string
  end
end

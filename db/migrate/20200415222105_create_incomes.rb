class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :category
      t.date :date
      t.decimal :amount

      t.timestamps
    end
  end
end

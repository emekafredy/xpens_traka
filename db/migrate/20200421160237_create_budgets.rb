class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :income_estimate, precision: 16, scale: 2
      t.decimal :expense_estimate, precision: 16, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

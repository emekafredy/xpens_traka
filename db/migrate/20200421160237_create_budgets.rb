class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.date :from
      t.date :to
      t.float :income_estimate
      t.float :expense_estimate
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

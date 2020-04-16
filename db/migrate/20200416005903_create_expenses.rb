class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :category
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end

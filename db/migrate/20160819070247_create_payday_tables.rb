class CreatePaydayTables < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      # invoices will work without anything but bill_to, but there are quite a few options for the fields you can save, like ship_to
      # due_at, refunded_at, and paid_at
      t.string :bill_to
      t.date :due_at
      t.date :refunded_at
      t.date :paid_at

      t.timestamps
    end

    create_table :line_items do |t|
      t.decimal :price
      t.string :description
      t.integer :quantity     # can also be :decimal or :float - just needs to be numeric

      t.references :invoice

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
    drop_table :line_items
  end
end

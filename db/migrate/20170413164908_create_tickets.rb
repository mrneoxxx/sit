class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :reference, null: false, index: { unique: true }
      t.string :customer, index: true
      t.string :title, null: false
      t.belongs_to :department, index: true
      t.belongs_to :status, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end


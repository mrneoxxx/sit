class CreateTicketComments < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_comments do |t|
      t.belongs_to :user
      t.belongs_to :ticket
      t.text :body, null: false
      t.timestamps
    end
  end
end

class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :ticket_comment
      t.belongs_to :user
      t.belongs_to :status
      t.timestamps
    end
  end
end

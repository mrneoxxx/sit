class AddStatusGroupToStatus < ActiveRecord::Migration[5.0]
  def change
    add_reference :statuses, :status_group, index: true
  end
end

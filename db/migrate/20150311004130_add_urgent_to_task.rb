class AddUrgentToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :urgent, :boolean
    remove_column :tasks, :urgeny_id
  end
end

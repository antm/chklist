class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :tasks, :urgent, :important
  end
end

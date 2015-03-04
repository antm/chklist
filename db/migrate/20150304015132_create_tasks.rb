class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :duedate
      t.datetime :endtime
      t.integer :position
      t.datetime :starttime
      t.integer :status_id
      t.string :title
      t.integer :urgency_id

      t.timestamps null: false
    end
  end
end

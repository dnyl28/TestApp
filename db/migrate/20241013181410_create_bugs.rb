class CreateBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.string :screenshot
      t.string :type
      t.string :status
      t.integer :creator_id
      t.integer :developer_id
      t.integer :project_id

      t.timestamps
    end
  end
end

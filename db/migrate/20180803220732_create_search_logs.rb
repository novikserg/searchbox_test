class CreateSearchLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :search_logs do |t|
      t.string :query
      t.integer :hits

      t.timestamps
    end
  end
end

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone_number
      t.string :badge_id

      t.timestamps
    end
  end
end

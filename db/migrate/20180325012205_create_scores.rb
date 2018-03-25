class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.float :value
      t.text :memo
      t.references :scorable, polymorphic: true, index: true

      t.timestamps
    end
  end
end

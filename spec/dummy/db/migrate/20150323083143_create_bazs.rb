class CreateBazs < ActiveRecord::Migration
  def change
    create_table :bazs do |t|
      t.string :type
      t.integer :factor
      t.references :foo, index: true

      t.timestamps
    end
  end
end

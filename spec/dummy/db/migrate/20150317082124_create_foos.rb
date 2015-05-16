class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :something
      t.string :type

      t.timestamps
    end
  end
end

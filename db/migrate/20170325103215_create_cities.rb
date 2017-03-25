class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.float :lattitude
      t.float :longitude

      t.timestamps
    end
  end
end

class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :external_id
      t.decimal :magnitude
      t.string :place
      t.string :time
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.decimal :coord_long
      t.decimal :coord_lat
      t.string :external_url

      t.timestamps
    end
  end
end

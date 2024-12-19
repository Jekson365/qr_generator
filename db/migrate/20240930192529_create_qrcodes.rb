class CreateQrcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :qrcodes do |t|
      t.string :url
      t.string :version
      t.string :box_size
      t.string :border
      t.references :user
      t.timestamps
    end
  end
end

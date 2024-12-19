class CreateUserImages < ActiveRecord::Migration[7.1]
  def change
    create_table :user_images do |t|
      t.string :image_path
      t.references :user
      t.timestamps
    end
  end
end

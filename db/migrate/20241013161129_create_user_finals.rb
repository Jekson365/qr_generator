class CreateUserFinals < ActiveRecord::Migration[7.1]
  def change
    create_table :user_finals do |t|
      t.references :user
      t.string :path
      t.timestamps
    end
  end
end

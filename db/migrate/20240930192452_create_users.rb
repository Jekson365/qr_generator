class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :ip_address
      t.string :user
      t.timestamps
    end
  end
end

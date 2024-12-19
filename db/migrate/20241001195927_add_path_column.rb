class AddPathColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :qrcodes,:path,:string
  end
end

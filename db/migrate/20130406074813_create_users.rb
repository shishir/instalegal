class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,       :null => false
      t.string :email,      :null => false
      t.string :password,   :null => false
      t.string :phone_number
      t.string :type,       :null => false
      t.timestamps
    end
  end
end

class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, :password
    end
  end
end

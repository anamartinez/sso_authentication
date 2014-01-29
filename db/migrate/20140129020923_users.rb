class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, :password
      t.belongs_to :account
    end
  end
end

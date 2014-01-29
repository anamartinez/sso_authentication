class Accounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain
    end
  end
end

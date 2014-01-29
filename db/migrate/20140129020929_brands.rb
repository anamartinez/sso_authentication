class Brands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :domain
      t.belongs_to :account
    end
  end
end

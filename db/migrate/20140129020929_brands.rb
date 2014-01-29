class Brands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :domain
    end
  end
end

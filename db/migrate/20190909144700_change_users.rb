class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :username
      t.string :first_name
      t.string :last_name
    end
  end
end
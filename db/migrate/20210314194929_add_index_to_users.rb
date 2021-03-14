class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, "EXTRACT('doy' FROM birthdate)", name: "index_user_on_bithdate_day_of_year"
  end
end

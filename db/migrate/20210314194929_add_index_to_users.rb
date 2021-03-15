class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, "(EXTRACT('day' FROM birthdate) || '-' || EXTRACT('month' FROM birthdate))", name: "index_user_on_birthdate_day_and_month"
  end
end

class AddBirthdateMdFormatToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birthdate_md_format, :string, index: true, null: false, limit: 4
  end
end

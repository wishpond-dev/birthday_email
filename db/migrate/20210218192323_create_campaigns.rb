class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns, id: :uuid do |t|
      t.string :key
      t.string :subject
      t.jsonb :subject_translations
      t.text :body
      t.jsonb :body_translations

      t.timestamps
    end
  end
end

# == Schema Information
#
# Table name: campaigns
#
#  id                   :uuid             not null, primary key
#  body                 :text
#  body_translations    :jsonb
#  key                  :string
#  subject              :string
#  subject_translations :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Campaign < ApplicationRecord
  translates :subject, :body
end

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

require 'rails_helper'

RSpec.describe Campaign, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

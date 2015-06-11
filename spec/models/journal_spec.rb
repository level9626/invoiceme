# == Schema Information
#
# Table name: journals
#
#  id               :integer          not null, primary key
#  event            :string(20)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)      default(""), not null
#  journalable_id   :integer          not null
#  journalable_type :string(255)      not null
#

require 'rails_helper'

RSpec.describe Journal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

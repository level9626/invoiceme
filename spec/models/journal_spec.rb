# == Schema Information
#
# Table name: journals
#
#  id         :integer          not null, primary key
#  invoice_id :integer
#  event      :string(20)
#  from       :string(20)
#  to         :string(20)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Journal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

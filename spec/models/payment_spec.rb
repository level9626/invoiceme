# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  invoice_id :integer          not null
#  amount     :float            not null
#  created_at :datetime
#  updated_at :datetime
#  currency   :string(255)
#

require 'rails_helper'

RSpec.describe Payment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)      not null
#  invoice_date   :datetime         not null
#  user_id        :integer          not null
#  currency       :string(255)      not null
#  comment        :text             default(""), not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

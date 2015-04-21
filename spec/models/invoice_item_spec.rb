# == Schema Information
#
# Table name: invoice_items
#
#  id             :integer          not null, primary key
#  description    :string(255)      default(""), not null
#  hours_or_tasks :float            not null
#  rate           :float            not null
#  invoice_id     :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :float            not null
#

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: invoice_mails
#
#  id                        :integer          not null, primary key
#  invoice_id                :integer          not null
#  to                        :string(255)     default([]), not null, is an Array
#  user_id                   :integer          not null
#  subject                   :string(255)
#  cc                        :string(255)      default([]), is an Array
#  body                      :text             not null
#  invoice_email_template_id :integer          not null
#  created_at                :datetime
#  updated_at                :datetime
#  from                      :string(255)
#  attachment                :boolean          default(TRUE), not null
#

require 'rails_helper'

RSpec.describe InvoiceMail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

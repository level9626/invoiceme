# == Schema Information
#
# Table name: invoice_email_templates
#
#  id               :integer          not null, primary key
#  name             :string(100)
#  template_body    :text
#  template_subject :string(255)
#  owner_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe InvoiceEmailTemplate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

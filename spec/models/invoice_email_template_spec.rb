# == Schema Information
#
# Table name: invoice_email_templates
#
#  id                     :integer          not null, primary key
#  name                   :string(100)
#  template_body          :text
#  template_subject       :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email_templatable_id   :integer
#  email_templatable_type :string(255)
#  to                     :string(255)      default([]), is an Array
#  cc                     :string(255)      default([]), is an Array
#  from                   :string(255)
#

require 'rails_helper'

RSpec.describe InvoiceEmailTemplate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

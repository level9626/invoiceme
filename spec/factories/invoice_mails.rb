# == Schema Information
#
# Table name: invoice_mails
#
#  id                        :integer          not null, primary key
#  invoice_id                :integer          not null
#  to                        :string(255)      default([]), not null,is an Array
#  user_id                   :integer          not null
#  subject                   :string(255)
#  cc                        :string(255)      default([]), is an Array
#  body                      :text             not null
#  invoice_email_template_id :integer          not null
#  created_at                :datetime
#  updated_at                :datetime
#  from                      :string(255)
#

FactoryGirl.define do
  factory :invoice_mail do
    invoice_id 1
    to ''
    user_id 1
    subject 'MyString'
    cc ''
    body 'MyText'
    invoice_email_template_id 1
  end
end

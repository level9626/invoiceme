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

FactoryGirl.define do
  factory :invoice_email_template do
    name 'MyString'
    template_body 'MyText'
    template_subject 'MyString'
    owner_id 'MyString'
  end
end

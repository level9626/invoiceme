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

FactoryGirl.define do
  factory :invoice_email_template do
    name 'MyString'
    template_body 'MyText'
    template_subject 'MyString'
    owner_id 'MyString'
  end
end

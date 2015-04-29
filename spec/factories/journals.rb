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

FactoryGirl.define do
  factory :journal do
    invoice_id 1
    event 'MyString'
    from 'MyString'
    to 'MyString'
  end
end

# == Schema Information
#
# Table name: journals
#
#  id               :integer          not null, primary key
#  event            :string(20)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)      default(""), not null
#  journalable_id   :integer          not null
#  journalable_type :integer          not null
#

FactoryGirl.define do
  factory :journal do
    invoice_id 1
    event 'MyString'
    from 'MyString'
    to 'MyString'
  end
end

# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  invoice_id :integer          not null
#  amount     :float            not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :payment do
    invoice_id 1
    amount 1.5
  end
end

# == Schema Information
#
# Table name: payments
#
#  id               :integer          not null, primary key
#  invoice_id       :integer          not null
#  amount           :float            not null
#  created_at       :datetime
#  updated_at       :datetime
#  currency         :string(255)
#  banking_overhead :integer
#

FactoryGirl.define do
  factory :payment do
    amount 100
    currency 'USD'
    invoice
  end
end

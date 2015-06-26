# == Schema Information
#
# Table name: invoice_items
#
#  id             :integer          not null, primary key
#  description    :string(255)      default(""), not null
#  hours_or_tasks :float            not null
#  rate           :float            not null
#  invoice_id     :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :float            not null
#

FactoryGirl.define do
  factory :invoice_item do
    description 'MyString'
    hours_or_tasks 150
    rate 10
    amount 150 * 10
    invoice

    factory :invoice_item_eq_ten do
      amount 10
    end
  end
end

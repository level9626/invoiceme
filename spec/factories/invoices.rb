# == Schema Information
#
# Table name: invoices
#
#  id               :integer          not null, primary key
#  invoice_number   :string(255)      not null
#  invoice_date     :datetime         not null
#  user_id          :integer          not null
#  currency         :string(255)      not null
#  comment          :text             default(""), not null
#  company_id       :integer          not null
#  client_id        :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  company_row_text :text             not null
#  client_row_text  :text             not null
#  subtotal         :float            not null
#  vat_rate         :float
#  vat              :float
#  discount         :float
#  state            :string(20)       default("new"), not null
#  net              :datetime
#

FactoryGirl.define do
  factory :invoice do
    invoice_number '#1'
    invoice_date Time.zone.now
    currency 'USD'
    comment Faker::Lorem.sentence
    company_row_text Faker::Lorem.sentence
    client_row_text Faker::Lorem.sentence
    subtotal 100

    # Factory associations
    client
    company
    user

    after(:create) do |invoice|
      create_list(:invoice_item, 5, invoice: invoice)
      invoice.subtotal = invoice.invoice_items.map(&:sum).reduce(:+)
    end
  end
end

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

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe :validation do
    it 'is valid' do
      expect(FactoryGirl.create(:invoice)).to be_valid
    end
  end

  # rubocop:disable all
  describe :subtotal do
    let (:invoice) { FactoryGirl.create(:invoice) }

    it 'Subtotal depends on invoice items amount sum' do
      10.times do |t|
        invoice.invoice_items.create(attributes_for(:invoice_item_eq_ten))
      end
      expect(invoice.subtotal).to be(100.0)
    end
  end
  # rubocop:enable all
end

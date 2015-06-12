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
      FactoryGirl.create(:invoice).should be_valid
    end
  end
end

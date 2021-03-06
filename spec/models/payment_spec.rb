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
require 'spec_helper'

# rubocop:disable all
describe Payment do
  it "has a valid payment factory" do
    expect(FactoryGirl.build(:payment)).to be_valid
  end

  let(:payment) { build(:payment) }

  describe "Payment validations" do
    # Basic validations
    it { expect(payment).to validate_presence_of(:invoice_id) }
    it { expect(payment).to validate_presence_of(:amount) }
    it { expect(payment).to validate_presence_of(:currency) }
    it { expect(payment).to validate_numericality_of(:amount)
                                         .is_greater_than_or_equal_to(0.1) }
    it { expect(payment).to validate_numericality_of(:banking_overhead)
                                         .is_greater_than_or_equal_to(0) }

    # Format validation
    context "matching values" do
      it { expect(payment).to allow_value(0.1).for(:amount) }
      it { expect(payment).to allow_value(999999).for(:amount) }
      it { expect(payment).to allow_value("USD").for(:currency) }
    end

    context "non-mathcing values" do
      it { expect(payment).to_not allow_value(0).for(:amount) }
      it { expect(payment).to_not allow_value(1111111).for(:amount) }
    end

    # Inclusion/acceptance of values
    it { expect(payment).to_not validate_inclusion_of(:amount).in_range(0.1..100) }
  end

  describe "Payment callbacks" do
    it { is_expected.to callback(:_update_invoice!).before(:create) }
    it { is_expected.to callback(:_log_edition!).before(:update) }
    it { is_expected.to callback(:_log_deletion!).before(:destroy) }
  end

  describe 'Units' do
    it { expect(payment.amount_with_currency).to match(/#{payment.currency}/) }
    it { expect(payment.amount_with_currency).to match(/#{payment.amount}/) }
  end

# rubocop:enable all
end

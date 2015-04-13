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
#  company_id       :integer
#  client_id        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  company_row_text :text             not null
#  client_row_text  :text             not null
#

class Invoice < ActiveRecord::Base
  belongs_to :company
  belongs_to :client
  belongs_to :user
  has_many   :invoice_items

  accepts_nested_attributes_for :invoice_items, :reject_if     => :all_blank,
                                                :allow_destroy => true
end

# == Schema Information
#
# Table name: invoice_mails
#
#  id                        :integer          not null, primary key
#  invoice_id                :integer          not null
#  to                        :string(255)      default([]), not null, is an Array
#  user_id                   :integer          not null
#  subject                   :string(255)
#  cc                        :string(255)      default([]), is an Array
#  body                      :text             not null
#  invoice_email_template_id :integer          not null
#  created_at                :datetime
#  updated_at                :datetime
#  from                      :string(255)
#

class InvoiceMail < ActiveRecord::Base
  ## Modules
  include Modules::MailFormater
  ## Relations
  belongs_to :invoice
  belongs_to :invoice_email_template
  belongs_to :user

  ## Validations
  validates :invoice_id, :user_id, :invoice_email_template_id, \
            numericality: true, presence: true
  validates :to, presence: true
  validates :subject, length: { in: 1..255 }
  validates :body, length: { in: 1..4000 }
end

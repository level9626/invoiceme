# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :text
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
  ## Relations
  has_many :mail_templates, as: :email_templatable, \
                            class_name: InvoiceEmailTemplate
  has_many :clients_users, dependent: :destroy
  has_many :users, through: :clients_users
  has_many :invoices, dependent: :destroy
  accepts_nested_attributes_for :users

  ## Validations
  validates :address, presence: true, length: { maximum: 300 }
end

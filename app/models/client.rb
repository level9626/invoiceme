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
  include Modules::TemplateImportable
  ## Relations
  has_many :clients_users, dependent: :destroy
  has_many :users, through: :clients_users
  has_many :invoices, dependent: :destroy
  accepts_nested_attributes_for :users

  ## Validations
  validates :name, presence: true, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 300 }

  ## Scopes
  default_scope { order('created_at DESC') }

  def invoice_statistics
  end
end

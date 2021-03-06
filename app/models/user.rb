# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  role                   :integer
#

class User < ActiveRecord::Base
  include Modules::TemplateImportable
  enum role: [:user, :vip, :admin]

  ## Gem Modules
  # Devise
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Relations
  has_many :clients_users
  has_many :clients, through: :clients_users
  has_many :invoices
  has_many :companies
  has_many :payments, through: :invoices
  has_many :invoice_mails

  ## Nested Forms
  accepts_nested_attributes_for :clients_users, :invoices, :companies

  ## Callbacks
  after_initialize :_set_default_role, if: :new_record?

  ## Instance Methods
  def logo_url
    companies.default.try(:logo_url) || 'fallback/default_logo.png'
  end

  def percent_payed
    normed_balance = invoices.normed_balance

    return 100 unless normed_balance
    (normed_balance).percent_of(invoices.sum(:subtotal))
  end

  private

  ## Callbacks Handlers
  # TODO: need to be tested
  def _set_default_role
    self.role ||= :user
  end
end

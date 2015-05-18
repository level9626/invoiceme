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
  enum role: [:user, :vip, :admin]

  ## Comments
  acts_as_commontator

  ## Relations
  has_many :clients_users
  has_many :clients, through: :clients_users
  has_many :invoices
  has_many :companies
  has_many :payments, through: :invoices
  has_many :invoice_mails
  has_many :mail_templates, as: :email_templatable, \
                            class_name: InvoiceEmailTemplate

  ## Nested Forms
  accepts_nested_attributes_for :clients_users, :invoices, :companies

  ## Callbacks
  after_initialize :_set_default_role, if: :new_record?
  after_create :_import_primary_invoice_templates

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Instance Methods
  def logo_url
    companies.default.try(:logo_url) || 'fallback/default_logo.png'
  end

  private

  ## Callbacks Handlers
  # TODO: need to be tested
  def _set_default_role
    self.role ||= :user
  end

  # Imports all admin primary templates for a given user.
  # User can have a separate template, based on default one.
  # Any updates in user templates should not cause issues for
  # primary admin templates.
  # TODO: need to be tested
  def _import_primary_invoice_templates
    return unless user?

    InvoiceEmailTemplate.primary.each do |invoice_template|
      mail_templates << invoice_template.dup
    end
  end
end

# == Schema Information
#
# Table name: invoice_email_templates
#
#  id                     :integer          not null, primary key
#  name                   :string(100)
#  template_body          :text
#  template_subject       :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email_templatable_id   :integer
#  email_templatable_type :string(255)
#  to                     :string(255)      default([]), is an Array
#  cc                     :string(255)      default([]), is an Array
#  from                   :string(255)
#  default                :boolean          default(FALSE), not null
#

class InvoiceEmailTemplate < ActiveRecord::Base
  ## Modules
  include Modules::MailFormater
  ## Relations
  belongs_to :email_templatable, polymorphic: true
  belongs_to :invoice
  has_many :invoice_mails
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  ## Validations
  validates :email_templatable_id, :email_templatable_type, :to, :cc, :from, \
            presence: true
  validates :name, :template_subject, length: { in: 1..255 }
  validates :template_body, length: { in: 1..4000 }
  validates :name, uniqueness: { scope: [:email_templatable_type, \
                                         :email_templatable_id], \
                                 message: 'name should be unique' }

  ## Scopes
  default_scope { order('created_at DESC') }
  scope :by_role, lambda { |role|
    # owner is actually referencing users table
    joins(%(
      INNER JOIN users ON
      users.id = invoice_email_templates.email_templatable_id
    ))
      .where(email_templatable_type: :User)
      .where(users: { role: User.roles[role] })
  }
  scope :primary, -> { by_role(:admin) }
  scope :user_templates, -> { by_role(:user) }

  ## Instance methods

  # need to use read_attribute[:name] in order to avoid infinite loop when
  # inside method name, attribute name is called.
  def name
    "#{email_templatable_type} template: #{self[:name]}"
  end
end

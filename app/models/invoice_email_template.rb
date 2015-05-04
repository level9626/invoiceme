# == Schema Information
#
# Table name: invoice_email_templates
#
#  id               :integer          not null, primary key
#  name             :string(100)
#  template_body    :text
#  template_subject :string(255)
#  owner_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class InvoiceEmailTemplate < ActiveRecord::Base
  ## Relations
  belongs_to :owner, class_name: User
  has_many :invoice_mails

  ## Validations
  validates :owner_id, presence: true
  validates :name, :template_subject, length: { in: 1..255 }
  validates :template_body, length: { in: 1..4000 }

  ## Scopes
  scope :by_role, lambda { |role|
    # owner is actually referencing users table
    joins(:owner).where(users: { role: User.roles[role] })
  }
  scope :primary, -> { by_role(:admin) }
  scope :user_templates, -> { by_role(:user) }
end

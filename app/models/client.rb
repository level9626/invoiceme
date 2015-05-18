# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :text
#  created_at :datetime
#  updated_at :datetime
#  email      :string(255)
#

class Client < ActiveRecord::Base
  before_save { self.email = email.downcase }

  ## Relations
  has_many :mail_templates, as: :email_templatable
  has_many :clients_users, dependent: :destroy
  has_many :users, through: :clients_users
  has_many :invoices, dependent: :destroy
  accepts_nested_attributes_for :users

  ## Validations
  validates :name, presence: true, length: { maximum: 150 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :address, presence: true, length: { maximum: 300 }
end

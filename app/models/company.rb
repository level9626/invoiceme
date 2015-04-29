# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  logo       :string(255)
#  name       :string(255)      not null
#  address    :text             not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  default    :boolean          default(FALSE), not null
#

class Company < ActiveRecord::Base
  mount_uploader :logo, LogoUploader

  ## Relations
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :payments, through: :invoices

  ## Validations
  validates :logo,    presence: true
  validates :name,    presence: true, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 300 }

  ## Callbacks
  before_save :change_default!, if: proc { |model| model.default }

  ## Class methods

  # Scope wont work here. Scope has a default behaviour to return
  # all records, when it returns nil.
  # Scopes should return ActiveRecord::Relation, not module. For
  # single record querying, use class methods.
  def self.default
    find_by(default: true)
  end

  private

  ## Callbacks Handlers

  # Changes default company for a user.
  # User can have only one default company.
  # TODO: need to be tested
  def change_default!
    Company.where(user_id: user_id).update_all(default: false)
  end
end

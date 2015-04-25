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
  ## Scopes
  scope :default, -> { find_by(default: true) }

  ## Relations
  belongs_to :user
  has_many :invoices
  has_many :payments, through: :invoices

  ## Validations
  validates :logo,    presence: true
  validates :name,    presence: true, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 300 }

  ## Callbacks
  before_save :change_default!, if: proc { |model| model.default }

  private

  ## Callbacks Handlers
  def change_default!
    Company.where(user_id: user_id).update_all(default: false)
  end
end

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
#

class Company < ActiveRecord::Base
  validates :logo,    presence: true
  validates :name,    presence: true, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 300 }

  belongs_to :user
  has_many :invoices

  mount_uploader :logo, LogoUploader
end

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
  validates :name,    presence: true, length: { maximum: 150 }
  validates :address, presence: true, length: { maximum: 300 }

  has_many :clients_users
  has_many :users, through: :clients_users
  has_many :invoices
  accepts_nested_attributes_for :users
end

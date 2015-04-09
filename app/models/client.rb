# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  company_name :string(255)
#  address      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Client < ActiveRecord::Base
  has_many :clients_users
  has_many :users, through: :clients_users
  accepts_nested_attributes_for :users
end

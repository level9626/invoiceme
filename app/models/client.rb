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
  has_and_belongs_to_many :users
end

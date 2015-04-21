# == Schema Information
#
# Table name: clients_users
#
#  user_id   :integer          primary key
#  client_id :integer          primary key
#

class ClientsUser < ActiveRecord::Base
  self.primary_key = :user_id, :client_id
  ## Relations
  belongs_to :user
  belongs_to :client

  ## Validations
  validates_presence_of :user
  validates_presence_of :client

  ## Nested Forms
  accepts_nested_attributes_for :client
end

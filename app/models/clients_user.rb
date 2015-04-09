class ClientsUser < ActiveRecord::Base
  self.primary_key = :user_id, :client_id
  belongs_to :user
  belongs_to :client

  validates_presence_of :user
  validates_presence_of :client

  accepts_nested_attributes_for :client

end
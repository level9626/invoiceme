# == Schema Information
#
# Table name: journals
#
#  id         :integer          not null, primary key
#  invoice_id :integer
#  event      :string(20)
#  from       :string(20)
#  to         :string(20)
#  created_at :datetime
#  updated_at :datetime
#

class Journal < ActiveRecord::Base
  ## Validations
  belongs_to :invoice

  ## Class Methods
  # TODO: need to be tested
  def self.log(obj, transition)
    obj.journals.create(transition.to_h)
  end
end

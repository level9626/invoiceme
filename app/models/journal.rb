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
  ## Relations
  belongs_to :invoice

  ## Validations
  validates :invoice_id, :event, :from, :to, presence: true
  validates :description, length: { maximum: 255 }

  ## Class Methods
  # TODO: need to be tested
  def self.log(obj, transition)
    transition = transition.to_h
    logger.info 'Journal*log' * 10
    logger.info transition
    logger.info 'Journal*log' * 10
    obj.journals.create(transition)
  end
end

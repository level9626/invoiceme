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
  # transition example => {:event=>:publish, :from=>"new", :to=>"open"}
  def self.log(obj, transition)
    transition = transition.to_h
    transition[:description] = I18n.t("journals.#{transition[:event]}", \
                                      amount: obj.payments
                                                .try(:last)
                                                .try(:amount_with_currency))
    obj.journals.create(transition)
  end
end

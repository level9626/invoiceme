# == Schema Information
#
# Table name: journals
#
#  id               :integer          not null, primary key
#  event            :string(20)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)      default(""), not null
#  journalable_id   :integer          not null
#  journalable_type :string(255)      not null
#

class Journal < ActiveRecord::Base
  ## Relations
  belongs_to :journalable, polymorphic: true

  ## Validations
  validates :journalable_id, :journalable_type, :event, presence: true
  validates :description, length: { maximum: 255 }

  ## Scopes
  default_scope { order('created_at DESC') }

  ## Class Methods

  # log object transition
  def self.log(obj, new_event, amount = nil)
    obj.journals.create(
      event: new_event,
      description: _i18n_for(obj, new_event, amount)
    )
  end

  # gets correct texts and translation for the event
  def self._i18n_for(obj, new_event, amount = nil)
    I18n.t("journals.#{new_event}", amount: amount || _args_for(obj)[new_event])
  end

  # gets arguments for i18n translations
  def self._args_for(obj)
    {
      publish: obj.payments.try(:last).try(:amount_with_currency),
      partly_pay: obj.payments.try(:last).try(:amount_with_currency)
    }
  end
end

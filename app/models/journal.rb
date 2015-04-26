class Journal < ActiveRecord::Base
  ## Validations
  belongs_to :invoice

  ## Class Methods
  def self.log(obj, transition)
    obj.journals.create(transition.to_h)
  end
end

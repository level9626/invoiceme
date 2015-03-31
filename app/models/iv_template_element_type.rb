class IvTemplateElementType < ActiveRecord::Base
  # TODO: refactor through method_missing
  scope :logo,        -> { find_by(name: 'logo') }
  scope :table,       -> { find_by(name: 'table') }
  scope :styled_text, -> { find_by(name: 'styled_text') }
  scope :label,       -> { find_by(name: 'label') }
end

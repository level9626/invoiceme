# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  logo       :string(255)
#  name       :string(255)      not null
#  address    :text             not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

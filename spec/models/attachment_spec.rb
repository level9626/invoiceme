# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  file            :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

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

FactoryGirl.define do
  factory :attachment do
    attachment 'MyString'
    attachable_id 1
    attachable_type 'MyString'
  end
end

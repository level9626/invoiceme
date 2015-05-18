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
#  default    :boolean          default(FALSE), not null
#  email      :string(255)
#

FactoryGirl.define do
  factory :company do
    logo 'MyString'
    name 'MyString'
    address 'MyText'
    user_id 1
  end
end

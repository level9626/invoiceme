# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  company_name :string(255)
#  address      :text
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :client do
    company_name "MyString"
address "MyText"
  end

end

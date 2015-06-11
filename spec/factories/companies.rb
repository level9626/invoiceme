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
    logo do
      path = File.join(Rails.root, 'spec', 'support', 'assets', 'img', '1.png')
      Rack::Test::UploadedFile.new(path)
    end
    name 'MyString'
    address 'MyText'
    email 'test@example.com'

    association :user, factory: :user, email: 'test1@example.com'
  end
end

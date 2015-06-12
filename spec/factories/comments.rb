# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :comment do
    content 'MyText'
    commentable_id 1
    commentable_type 'MyString'
  end
end

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

class Comment < ActiveRecord::Base
  ## Relations
  belongs_to :commentable, polymorphic: true
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, allow_destroy: true

  ## Validations
  validates :content, presence: true, length: { in: 1..300 }

  ## Scopes
  default_scope { order('created_at DESC') }
end

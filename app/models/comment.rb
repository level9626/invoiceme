class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :content, presence: true, length: { maximum: 5 }
end

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :attachments, as: :attachable
  validates :content, presence: true, length: { maximum: 5 }
end

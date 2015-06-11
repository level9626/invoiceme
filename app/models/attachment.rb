# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  attachment      :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  mount_uploader :attachment, AttachmentUploader
end

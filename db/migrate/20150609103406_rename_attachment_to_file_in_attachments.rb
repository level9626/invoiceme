class RenameAttachmentToFileInAttachments < ActiveRecord::Migration
  def change
    rename_column :attachments, :attachment, :file
  end
end

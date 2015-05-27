class AddAttachmentToInvoiceMails < ActiveRecord::Migration
  def change
    add_column :invoice_mails, :attachment, :boolean, null: false, default: true
  end
end

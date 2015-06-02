class RemoveAttachmentFromInvoiceMails < ActiveRecord::Migration
  def change
    remove_column :invoice_mails, :attachment
  end
end

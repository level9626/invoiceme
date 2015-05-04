class CreateInvoiceMails < ActiveRecord::Migration
  def change
    create_table :invoice_mails do |t|
      t.integer :invoice_id, index: true, null: false
      t.string :to, null: false, array: true, default: '{}'
      t.integer :user_id, index: true, null: false
      t.string :subject
      t.string :cc, array: true, default: '{}'
      t.text :body, null: false
      t.integer :invoice_email_template_id, index: true, null: false

      t.timestamps
    end
  end
end

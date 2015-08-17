class InvoicesStateChangeMigration < ActiveRecord::Migration
  def change
    Invoice.where(state: 'new').update_all(state: 'draft')
    Invoice.where(state: 'partly_paid').update_all(state: 'partly')
    Invoice.where(state: 'closed').update_all(state: 'paid')
  end
end

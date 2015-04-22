# Event machine for Invoices model
# In my opinion, State Machines can grow very big and ugly, and it's not a
# good idea to mix it with all other business logic.
module InvoiceMachine
  # Apparently, modules doesn't have all state machine goodness added.
  # This is a small workaround to store state machine in separate file
  # Hack to add state_machine to parent class
  # rubocop:disable all
  def self.extended(klass) # rubocop:disable MethodLength
    klass.send :state_machine, initial: :new do
      # Defining main states
      state :new, value: 'new'
      state :open, value: 'open'
      state :partly_paid, value: 'partly_paid'
      state :closed, value: 'closed'
      state :overdue, value: 'overdue'
      state :bad_dept, value: 'bad_dept'

      # Defining main transitions
      event :publish do
        transition new: :open
      end

      event :close do
        transition open: :closed
      end

      event :pay_partly do
        transition open: :partly_paid
      end

      event :overdue do
        transition open: :overdue
      end

      event :bad_dept do
        transition open: :bad_dept
      end
    end
  end
end

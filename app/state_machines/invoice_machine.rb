# Event machine for Invoices model
# In my opinion, State Machines can grow very big and ugly, and it's not a
# good idea to mix it with all other business logic.
module InvoiceMachine
  # Apparently, modules doesn't have all state machine goodness added.
  # This is a small workaround to store state machine in separate file
  # Hack to add state_machine to parent class
  def self.included(klass) # rubocop:disable all
    const_set :OPEN_STATUSES, [:open, :partly_paid, :overdue, :bad_debt]

    klass.send :state_machine, initial: :new do
      # Defining main states
      state :new, value: :new
      state :open, value: :open
      state :partly_paid, value: :partly_paid
      state :closed, value: :closed
      state :overdue, value: :overdue
      state :bad_debt, value: :bad_debt

      # Defining main transitions
      event :publish do
        transition new: :open
      end

      event :partly_pay do
        transition OPEN_STATUSES => :partly_paid
      end

      event :overdue do
        transition OPEN_STATUSES => :overdue
      end

      event :bad_debt do
        transition OPEN_STATUSES => :bad_debt
      end

      event :close do
        transition OPEN_STATUSES => :closed
      end

      # Generic transition callback *after* the transition is performed
      after_transition do |obj, transition|
        Journal.log(obj, transition) # obj is the record
      end
    end
  end
end
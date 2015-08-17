# Event machine for Invoices model
# In my opinion, State Machines can grow very big and ugly, and it's not a
# good idea to mix it with all other business logic.
module InvoiceMachine
  # Apparently, modules doesn't have all state machine goodness added.
  # This is a small workaround to store state machine in separate file
  # Hack to add state_machine to parent class
  def self.included(klass) # rubocop:disable all
    const_set :OPEN_STATUSES, [:open, :partly, :overdue, :bad_debt]

    klass.send :state_machine, initial: :draft do
      # Defining main states
      state :draft, value: 'draft'
      state :open, value: 'open'
      state :unpaid, value: 'unpaid'
      state :partly, value: 'partly'
      state :paid, value: 'paid'
      state :overdue, value: 'overdue'
      state :bad_debt, value: 'bad_debt'

      # Defining main transitions
      event :publish do
        transition draft: :open
      end

      event :partly_pay do
        transition OPEN_STATUSES => :partly
      end

      event :overdue do
        transition OPEN_STATUSES => :overdue
      end

      event :bad_debt do
        transition OPEN_STATUSES => :bad_debt
      end

      event :close do
        transition OPEN_STATUSES => :paid
      end

      # Generic transition callback *after* the transition is performed
      # transition example => {:event=>:publish, :from=>"new", :to=>"open"}
      # obj is an record
      after_transition do |obj, transition|
        Journal.log(obj, transition.to_h[:event])
      end
    end
  end
end

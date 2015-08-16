module Modules
  module ProfileStatistics
    def profile_statistics
      {
        states: _stat_by_state,
        percent_by_state: _percent_by_state.to_a,
        invoices_count: self.count
      }
    end

    private

    def _stat_by_state
      Invoice::STATE.map do |state|
        # state open represents open invoices in the system, but open also is
        # an method defined in ruby, for instances. That is why open is renamed
        # to is_open scope on the line below.
        invcs = self.send(state=='open' ? 'is_open' : state)
        {
          state.to_sym => {
            invoices: _with_label(invcs.count, 'invoices'),
            uah: _with_label(invcs.uah.normed_balance, 'UAH'),
            usd: _with_label(invcs.usd.normed_balance, 'USD'),
            eur: _with_label(invcs.eur.normed_balance, 'EUR')
          }
        }
      end
      .reduce({}, :merge)
    end

    def _with_label(value, label)
      return '-' unless value
      return '-' if value.zero?
      "#{value} #{label}"
    end

    def _percent_by_state
      ids = self.pluck(:user_id).uniq.map{|s| "'#{s}'"}.join(', ')
      ActiveRecord::Base.connection.execute(<<-SQL)
        SELECT
        state as label,
        round((COUNT(*) * 100.00 /
                ( SELECT count(*) from invoices WHERE user_id IN (#{ids}) )), 2)
        as value
        FROM invoices
        WHERE user_id IN (#{ids})
        GROUP BY state;
      SQL
    end
  end
end

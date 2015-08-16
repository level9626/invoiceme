module Modules
  module ProfileStatistics
    def profile_statistics(user_id)
      @invcs = Invoice.where(user_id: user_id)
      {
        states: _stat_by_state(user_id),
        percent_by_state: _percent_by_state(user_id).to_a,
        invoices_count: @invcs.count
      }
    end

    private

    def _stat_by_state(user_id)
      Invoice::STATE.map do |state|
        # state open represents open invoices in the system, but open also is
        # an method defined in ruby, for instances. That is why open is renamed
        # to is_open scope on the line below.
        invcs = @invcs.send(state=='open' ? 'is_open' : state)
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

    def _percent_by_state(user_id)
      ActiveRecord::Base.connection.execute(<<-SQL)
        SELECT
        state as label,
        round((COUNT(*) * 100.00 /
                (SELECT count(*) from invoices WHERE user_id=#{user_id})), 2)
        as value
        FROM invoices
        WHERE user_id=#{user_id}
        GROUP BY state;
      SQL
    end
  end
end

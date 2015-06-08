module Modules
  module WithCurrency
    private

    def _with_currency(amount)
      return '--/--' unless amount
      return '--/--' if amount.to_i.zero?
      "#{amount} #{currency}"
    end
  end
end

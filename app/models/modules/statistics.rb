module Modules
  module Statistics
    def self.build_statistics(user)
      connection.execute(<<-SQL)
        SELECT status, 
               count(*) AS count_invoices,
               sum(unpayed_usds.amount) AS unpayed_usd,
               sum(unpayed_uahs.amount) AS unpayed_uah,
               sum(unpayed_eurs.amount) AS unpayed_eur,
        FROM invoices
        WHERE user_id=#{user.id}
        GROUP BY state;
      SQL
    end
  end
end

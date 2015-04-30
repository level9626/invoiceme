class NetsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  if Rails.env.production?
    recurrence { hourly(24) }
  else
    recurrence { minutely(1) }
  end

  def perform
    @invoices = Invoice.where('net>?', Time.zone.now)
    @invoices.map(&:overdue)
  end
end

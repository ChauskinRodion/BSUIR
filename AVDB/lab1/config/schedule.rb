every 2.minutes do
  sidekiq 'CurrencyUpdateWorker.perform_async'
end

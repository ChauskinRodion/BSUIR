class ClientsNotifyWorker
  include Sidekiq::Worker

  ###################### require for debugging async. workers
  # require 'sidekiq'
  # require 'sidekiq/testing/inline'

  def perform(params)
    model = params['type'].constantize
    body = params['message']
      if params['ids']
      model.find(params['ids']).each do |client|
        email = client.is_a?(Person) ? client.email : client.chief.email
        ClientMailer.notification_email(email, body).deliver
      end
    end
  end
end

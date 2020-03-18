class QueueSubscriptionService
  def subscribe(log_method)
    channel = RabbitMQ.connection.create_channel
    queue = channel.queue("banking.transaction_log", :auto_delete => false )

    queue.subscribe do |delivery_info, metadata, payload|
      log_method.call(payload)
    end
  end
end
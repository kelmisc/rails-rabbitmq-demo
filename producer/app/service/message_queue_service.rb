class MessageQueueService

  def publish(payload)
    channel = RabbitMQ.connection.create_channel
    queue = channel.queue("banking.transaction_log", :auto_delete => false )
    exchange = channel.default_exchange
    exchange.publish(payload.to_json, routing_key: queue.name)
  end
end
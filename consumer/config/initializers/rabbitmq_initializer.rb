class RabbitMQ
  def self.connection
    @@_connection ||=
      begin
        instance = Bunny.new
        instance.start
        instance
      end
  end

end


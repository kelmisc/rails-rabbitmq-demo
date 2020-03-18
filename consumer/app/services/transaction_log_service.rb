class TransactionLogService
  include Singleton

  def initialize
    @worker = nil
    @message_queue = QueueSubscriptionService.new
  end

  def start_print
    @worker = Thread.new { receive_print_log }
    @worker.abort_on_exception = true
  end

  def stop_print
    Thread.kill @worker
  end

  private

  def receive_print_log
    print_console = Proc.new{ |log| puts log }
    @message_queue.subscribe(print_console)
  end

end
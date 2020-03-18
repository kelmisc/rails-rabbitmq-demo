class ConsumeController < ActionController::API

  def initialize
    @transaction_log = TransactionLogService.instance
  end

  def start
    begin
      @transaction_log.start_print
      render status: 200
    rescue Exception => e
      puts e
      render status: 500
    end
  end

  def stop
    begin
      @transaction_log.stop_print
      render status: 200
    rescue Exception => e
      puts e
      render status: 500
    end
  end
end
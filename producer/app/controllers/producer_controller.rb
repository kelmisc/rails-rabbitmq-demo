class ProducerController < ApplicationController
  def initialize
    @random_transaction = RandomTransactionService.instance
  end

  def start
    begin
      @random_transaction.start
      render status: 200
    rescue
      render status: 500
    end
  end

  def stop
    begin
      render json: @random_transaction.stop, status: 200
    rescue
      render status: 500
    end
  end
end
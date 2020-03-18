require 'SecureRandom'

class RandomTransactionService
  include Singleton

  def initialize
    @workers = []
    @transaction_logs = Concurrent::Array.new
    @message_queue = MessageQueueService.new
  end

  def start
    @workers << Thread.new { process_random_transaction }
    @workers << Thread.new { process_random_transaction prodcuer_id: "02", account_id: "02"}
    @workers << Thread.new { process_random_transaction prodcuer_id: "03", account_id: "03"}
  end

  def stop
    @workers.each {|t| Thread.kill t}

    account_info = []
    Account.all.each do
      |account| account_info << {account_id: account.account_id, balance: account.balance}
    end

    {accounts: account_info, logs: @transaction_logs}
  end

  private

  def process_random_transaction(prodcuer_id: "01" ,account_id: "01")
    loop do
      account = Account.find_by(account_id: account_id)

      amount = RandomHelper.gen_random
      while (amount + account.balance) < 0
        amount = RandomHelper.gen_random
      end

      log_entry = {
          prodcuer_id: prodcuer_id,
          transaction_id: SecureRandom.uuid,
          amount: amount,
          balance: account.balance + amount
      }
      @transaction_logs << log_entry
      @message_queue.publish(log_entry)

      account.balance += amount
      account.save!
      sleep rand(1...35)
    end
  end

end
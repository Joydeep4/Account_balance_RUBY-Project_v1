class FetchTransactions
  class Transaction
    attr_accessor :account_number, :transaction_date, :transaction_amount, :fee_amount

    def initialize(account_number, transaction_date, transaction_amount, fee_amount)
      @account_number = account_number
      @transaction_date = transaction_date
      @transaction_amount = transaction_amount
      @fee_amount = fee_amount
    end
  end

  @transactions_table = []

  class << self
    attr_accessor :transactions_table
  end

  def initialize
    initialize_transactions
  end

  def initialize_transactions
    # Initialize the in-memory transaction data
    self.class.transactions_table += [
      Transaction.new("1234567890", "20240101", 1000.00, 5.00),
      Transaction.new("1234567890", "20240102", 500.00, 3.00),
      Transaction.new("0987654321", "20240103", 700.00, 2.00),
      Transaction.new("5555555555", "20240104", 1500.00, 9.00)
    ]
  end

  def display_transactions(account_number)
    matching_transactions = fetch_transactions(account_number)

    if matching_transactions.empty?
      puts "No transactions found for account number: #{account_number}"
    else
      matching_transactions.each do |transaction|
        puts "Transaction Date: #{transaction.transaction_date}"
        puts "Transaction Amount: #{transaction.transaction_amount}"
        puts "Fee Amount: #{transaction.fee_amount}"
      end
      puts "End of Transactions."
    end
  end

  def fetch_transactions(account_number)
    self.class.transactions_table.select { |transaction| transaction.account_number == account_number }
  end
end

# Example usage:
# fetcher = FetchTransactions.new
# fetcher.display_transactions("1234567890")
# fetcher.display_transactions("9999999999")

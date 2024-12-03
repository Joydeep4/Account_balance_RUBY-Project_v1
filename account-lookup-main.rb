# Use __dir__ to ensure the paths are correctly resolved relative to this file
require_relative "#{__dir__}/UpdateBalance"
require_relative "#{__dir__}/CalculateFees"

#class Account
#  attr_accessor :account_number, :current_balance
#
#  def initialize(account_number, current_balance)
#    @account_number = account_number
#    @current_balance = current_balance
#  end
#end


class Account
  attr_accessor :account_number, :balance

  def initialize(account_number, balance)
    @account_number = account_number
    @balance = balance
  end

  def get_account_number
    @account_number
  end

  def get_balance
    @balance
  end

  def set_balance(new_balance)
    @balance = new_balance
  end
end


class Transaction
  attr_accessor :account_number, :transaction_type, :transaction_amount, :fee_amount

  def initialize(account_number, transaction_type, transaction_amount, fee_amount)
    @account_number = account_number
    @transaction_type = transaction_type
    @transaction_amount = transaction_amount
    @fee_amount = fee_amount
  end
end

# Define the `main` method to accept `accounts` and `transactions` as arguments
def check_balance(account_number, accounts)
  account = accounts.find { |acc| acc.account_number == account_number }
  if account
    puts "Current balance for account #{account_number}: #{account.current_balance}"
  else
    puts "Account #{account_number} not found."
  end
end

def display_transactions(account_number, transactions)
  account_transactions = transactions.select { |txn| txn.account_number == account_number }
  if account_transactions.any?
    account_transactions.each do |txn|
      puts "Type: #{txn.transaction_type}, Amount: #{txn.transaction_amount}, Fee: #{txn.fee_amount}"
    end
  else
    puts "No transactions found for account #{account_number}."
  end
end

def main(accounts, transactions)
  update_balance_instance = UpdateBalance.new(accounts)

  puts "Select Operation: (B - Balance, T - Transactions, U - Update Balance):"
  operation_code = gets.strip.upcase

  puts "Enter Account Number:"
  account_number = gets.strip

  case operation_code
  when 'B'
    puts "Balance Inquiry Selected."
    check_balance(account_number, accounts)
  when 'T'
    puts "Transactions Inquiry Selected."
    display_transactions(account_number, transactions)
  when 'U'
    puts "Update Balance Selected."
    puts "Enter Transaction Type (W - Withdrawal, D - Deposit, RD - Recurring Deposit):"
    transaction_type = gets.strip.upcase
    
    puts "Enter Transaction Amount:"
    transaction_amount = gets.strip.to_f

    account = accounts.find { |acc| acc.account_number == account_number }
    unless account
      puts "Account #{account_number} not found."
      return
    end

    # Update balance
    new_balance = update_balance_instance.update_balance(account_number, transaction_amount, transaction_type)
    if new_balance
      # Calculate fees
      fee_amount = CalculateFees.calculate_fees(account, transaction_amount, transaction_type)
      transactions << Transaction.new(account_number, transaction_type, transaction_amount, fee_amount)
    end
  else
    puts "Invalid selection. Please enter B, T, or U."
  end
end

# Initialize the `accounts` and `transactions` outside the `main` method
accounts = [
  Account.new("1234567890", 500.00),
  Account.new("0987654321", 1000.00),
  Account.new("5555555555", 1500.00),
  Account.new("1239874560", 2000.00),
  Account.new("3216549870", 750.00)
]

transactions = []

# Call the `main` method with `accounts` and `transactions`
if __FILE__ == $PROGRAM_NAME
  main(accounts, transactions)
end

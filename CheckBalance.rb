class CheckBalance
  MINIMUM_BALANCE = 500.00

  # Simulating the COBOL OCCURS clause with a list of accounts
  class Account
    attr_reader :account_number, :current_balance

    def initialize(account_number, current_balance)
      @account_number = account_number
      @current_balance = current_balance
    end
  end

  # Initializing the accounts table
  @accounts_table = [
    Account.new("1234567890", 1000.00),
    Account.new("0987654321", 300.00),
    Account.new("1122334455", 800.00),
    Account.new("5555555555", 1500.00),  # Additional account for simulation
    Account.new("6677889900", 200.00)    # Additional account for simulation
  ]

  @validation_status = nil

  class << self
    attr_accessor :validation_status, :accounts_table

    def check_balance(input_account_number)
      account_found = false
      current_balance = 0.00

      # Search for the account in the accounts table
      @accounts_table.each do |account|
        # Debugging statement (can be uncommented if needed)
        # puts "Checking account: #{account.account_number}"
        if account.account_number == input_account_number
          account_found = true
          current_balance = account.current_balance
          puts "Current balance amount is: #{current_balance}"
          break
        end
      end

      # Validate account information
      if !account_found
        puts "Account not found."
        @validation_status = "ERR"
      else
        if current_balance < MINIMUM_BALANCE
          puts "Account balance below minimum required."
          @validation_status = "ERR"
        else
          puts "Account meets minimum balance requirement."
          @validation_status = "OK"
        end
      end
    end

    def get_validation_status
      @validation_status
    end
  end
end

# Example usage
CheckBalance.check_balance("1234567890") # Current balance amount is: 1000.0
puts CheckBalance.get_validation_status   # OK

CheckBalance.check_balance("0987654321") # Current balance amount is: 300.0
puts CheckBalance.get_validation_status   # ERR

CheckBalance.check_balance("9999999999") # Account not found.
puts CheckBalance.get_validation_status   # ERR

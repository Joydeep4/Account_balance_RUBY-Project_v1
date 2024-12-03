class UpdateBalance
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

  def initialize(accounts)
    @accounts = accounts
  end

  def update_balance(account_number, transaction_amount, transaction_type = nil)
    record_found = false
    state_tax_fee = 5.00 # State tax fee if balance exceeds 2500 after deposit

    # Search for the account in the accounts list
    @accounts.each do |account|
      if account.get_account_number == account_number
        record_found = true

        case transaction_type
        when 'W' # Withdrawal
          if account.get_balance < transaction_amount
            puts "Insufficient balance. Withdrawal cancelled."
            return nil
          end
          new_balance = account.get_balance - transaction_amount
          
        when 'RD' # Recurring Deposit
          # Add 50% of the transaction amount to the balance
          additional_amount = transaction_amount * 0.5
          new_balance = account.get_balance + transaction_amount + additional_amount
          puts "Recurring Deposit applied. Additional amount: #{additional_amount}"
          
          # Check for balance exceeding 2500 after deposit
          if new_balance > 2500
            puts "State tax fee of #{state_tax_fee} applied."
            new_balance -= state_tax_fee # Deduct state tax fee
          end
        when 'D' # Deposit
          new_balance = account.get_balance + transaction_amount

          # Check for balance exceeding 2500 after deposit
          if new_balance > 2500
            puts "State tax fee of #{state_tax_fee} applied."
            new_balance -= state_tax_fee # Deduct state tax fee
          end
        else
          puts "Invalid transaction type. Use 'W' for withdrawal, 'D' for deposit, or 'RD' for recurring deposit."
          return nil
        end

        # Update the account balance
        account.set_balance(new_balance)
        puts "Transaction successful. New balance: #{new_balance}"
        return new_balance # Return updated balance for further use
      end
    end

    unless record_found
      puts "Account not found."
      nil
    end
  end
end

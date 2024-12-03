class CalculateFees
  MINIMUM_BALANCE = 500.00
  WITHDRAWAL_FEE = 2.00
  LOW_BALANCE_FEE = 5.00

  def self.calculate_fees(account, transaction_amount, transaction_type)
    fee_amount = 0.00

    # Apply low balance fee if applicable
    if account.get_balance < MINIMUM_BALANCE
      fee_amount += LOW_BALANCE_FEE
    end

    # Apply withdrawal fee if applicable
    if transaction_type == 'W'
      fee_amount += WITHDRAWAL_FEE
    end

    # Deduct the fee from balance
    account.set_balance(account.get_balance - fee_amount)
    puts format("Fees applied: %.2f", fee_amount)
    puts format("New balance after fees: %.2f", account.get_balance)
    fee_amount
  end
end

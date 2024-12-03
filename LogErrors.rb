require 'time'

class LogErrors
  class ErrorLogEntry
    attr_accessor :timestamp, :account_number, :module_name, :error_code, :error_message

    def initialize(timestamp, account_number, module_name, error_code, error_message)
      @timestamp = timestamp
      @account_number = account_number
      @module_name = module_name
      @error_code = error_code
      @error_message = error_message
    end

    def to_s
      <<~ENTRY
        Timestamp: #{@timestamp}
        Account Number: #{@account_number}
        Module Name: #{@module_name}
        Error Code: #{@error_code}
        Error Message: #{@error_message}
      ENTRY
    end
  end

  def initialize
    # Simulate an in-memory log file
    @error_log_array = []
    @log_index = 0  # Start index at 0
  end

  def log_error(account_number, module_name, error_code, error_message)
    # Get the current timestamp
    current_timestamp = self.class.get_current_timestamp

    # Create a new error log entry and add it to the list
    entry = ErrorLogEntry.new(
      current_timestamp,
      account_number,
      module_name,
      error_code,
      error_message
    )
    @error_log_array << entry
    @log_index += 1

    # Simulate displaying the log entry after it's stored
    puts "Error logged successfully:"
    puts entry
  end

  def self.get_current_timestamp
    # Get the current date and time in "YYYYMMDD HHMMSS" format
    Time.now.strftime("%Y%m%d %H%M%S")
  end

  def get_error_logs
    # Return all logged errors
    @error_log_array
  end
end

# Example Usage:
# logger = LogErrors.new
# logger.log_error("12345", "ModuleA", "404", "Not Found")
# logger.log_error("67890", "ModuleB", "500", "Internal Server Error")
# logs = logger.get_error_logs
# logs.each { |log| puts log }

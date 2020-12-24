class CashMachine
  def initialize
    @start_balance = 100
  end

  def deposit_amount
    puts 'Deposit amount:'
    deposit_amount = gets.to_i
    if deposit_amount > 0
      @start_balance += deposit_amount
      File.open('balance.txt', 'w') { |f| f.write @start_balance }
    else puts 'Deposit must be greater than 0.!Enter a deposit greater than 0!'
    end
  end

  def withdrawal_amount
    withdrawal_amount = gets.to_i
    if withdrawal_amount > 0 && withdrawal_amount <= @start_balance
      @start_balance -= withdrawal_amount
      File.open('balance.txt', 'w') { |f| f.write @start_balance }
    else puts 'Enter withdrawal amount  grater than 0 and equal to or less than balance !'
    end
  end

  def balance
    loop do
      if File.file?('balance.txt') && !File.zero?('balance.txt')
        file = File.open('balance.txt')
        start_balance = file.read.to_i
        file.close
      else puts 'File empty'
           start_balance = 100.to_i
      end

      puts 'Select operation action:'
      puts 'D (deposit_amount)'
      puts 'W (withdraw)'
      puts 'B (balance)'
      puts 'Q (quit)'
      puts ' '

      operation = gets.chomp.upcase!
      case operation
      when 'D'
        deposit_amount
      when 'W'
        withdrawal_amount
      when 'B'
        puts "Your balance: #{start_balance}"
      when 'Q'
        break
      else
        puts 'Enter any of the above letters or enter Q to exit'
      end
    end
  end

  def self.init
    CashMachine.new.balance
  end
end
CashMachine.init
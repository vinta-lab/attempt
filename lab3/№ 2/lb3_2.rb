BALANCE = 100.0

play = true

while play

  if File.file?('balance.txt') && !File.zero?('balance.txt')
    file = File.open('balance.txt')
    start_balance = file.read.to_i
    file.close
  else
    puts 'File balance.txt does not exist or is empty'
    puts ''
    start_balance = BALANCE.to_i
  end

  puts "Balance: #{start_balance}"
  puts 'What do you want to do?'
  puts ''
  puts 'D (deposit_amount)'
  puts 'W (withdraw)'
  puts 'B (balance)'
  puts 'Q (quit)'
  puts ''

  operation = gets.chomp.upcase!

  case operation
  when 'D'
    puts ''
    print 'deposit_amount amount: '
    deposit_amount_amount = gets.to_i
    if deposit_amount > 0
      start_balance += deposit_amount
      File.open('balance.txt', 'w') { |f| f.write start_balance }
    else
      puts 'Enter an amount greater 0'
      puts ''
      end
  when 'W'
    puts ''
    print 'Withdrawal amount: '
    withdrawal_amount = gets.to_i
    if (withdrawal_amount > 0 && withdrawal_amount <= start_balance) && start_balance != 0
      start_balance -= withdrawal_amount
      File.open('balance.txt', 'w') { |f| f.write start_balance }
    else
      puts 'The amount must be greater zero and less or equal to current balance.'
      print 'And the balance should not be less than or equal to zero.'
      puts ''
    end
  when 'B'
    next
  when 'Q'
    play = false
    break
  else
    puts 'Wrong letter...'
    puts ''
  end

end
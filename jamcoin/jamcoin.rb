#first need a way to check for prime number
def is_prime?(num)
  return false if num <= 1
  2.upto(1000).each {|i| return i if num % i == 0}
  true
end

input = gets.chomp.to_i

input = gets.chomp.split(" ")

jam_length = input[0].to_i
jam_count = input[1].to_i
found_jam_coins = 0
jamcoins = []
divisors = [] 

current_coin = []
[*0...jam_length].each do |count|
    if count == 0 || count == jam_length - 1
        current_coin.push("1")
    else
        current_coin.push("0")
    end
end
#we now have the base 10 version of the coin. this will help us to get
#the next version of the coin each time by adding 2 to the number
jamcoinbase10 = current_coin.join('').to_i(2)
prime_flag = false

while found_jam_coins < jam_count do
    divisors[found_jam_coins] = []
    jamcoins[found_jam_coins] = current_coin.join('')
    # current_coin.split('')
    [*2..10].each do |base| 
        if !prime_flag
            coinvalue = current_coin.join('').to_i(base)
            result = is_prime?(coinvalue)
            if result === true
                #this value is prime and as such not a jamcoin set 
                prime_flag = true
                jamcoins[found_jam_coins] = ""
                divisors[found_jam_coins] = []
            else
                # value is not prime and still a possible jamcoin
                divisors[found_jam_coins][base - 2] = result
            end
            #loop around will chech the next base
        end
    end
    # all bases checked. look at the prime flag
    if !prime_flag
        #this is a valid coin since no primes were found increase the found jam_coins
        found_jam_coins += 1
    end
    #move onto the next possible coin. do this by adding 2 to the jamcoinbase10
    jamcoinbase10 += 2
    #convert this into a binary string
    current_coin = jamcoinbase10.to_s(2).split('')
    #reset prime flag
    prime_flag = false
end

#should have found all jam coins lets print

puts "Case #1:"
[*0...jam_count].each do |index|
    output = ""
    output = "#{jamcoins[index]}"
    divisors[index].each do |divisor|
        output += " #{divisor}"
    end
    puts output
end
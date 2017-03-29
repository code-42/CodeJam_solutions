def count_sheep(number)
    if number == 0 
        return "INSOMNIA"
    end
    
    digitArray = []
    10.times do
        digitArray.push(false)
    end
    counter = 1
    while digitArray.include? false do
        temp = number * counter
        # puts temp
        while temp > 0 do
           digit = temp % 10
           digitArray[digit] = true
           temp = (temp / 10).floor
        end
        # puts digitArray
        counter += 1
    end
    return number * (counter - 1)
end

def get_input
    return gets.chomp.to_i
end

# first get the number of tests

tests = gets.chomp

#now run that many tests
tests = tests.to_i

index = 0
tests.times do 
    index += 1
    input = get_input
    puts "Case ##{index}: #{count_sheep(input)}"
end
def getStackHeight(stack)
    height = 1
    if stack.length == 1 
        return 1
    end
    
    [*1...stack.length].each do |count|
        if stack[count] != stack[count - 1]
            height += 1
        end
    end
    
    return height
    
end

def flipping_pancakes(input)
    stack = input.split('')
    stack_height = getStackHeight(stack)
    
    if stack[stack.length - 1] == "-"
        return stack_height
    else
        return stack_height - 1
    end
end

tests = gets.chomp

#now run that many tests
tests = tests.to_i

index = 0
tests.times do 
    index += 1
    input = gets.chomp
    puts "Case ##{index}: #{flipping_pancakes(input)}"
end
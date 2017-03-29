@flips = 0
 
def check_stack(stack)
    counts = Hash.new 0
    stack.each do |pancake|
        counts[pancake] += 1
    end
    if counts["-"] > counts["+"]
        stack = flip(stack, stack.length)
        @flips += 1
    end
    return stack
end

def flip(stack, index)
    flip_array = []
    [*0...index].reverse.each do |item|
        if stack[item] == "+"
            flip_array.push("-")
        else
            flip_array.push("+")
        end
    end
    #now have a reversed and flipped segment
    # example stack - - + - and index was 3. flip array will contain [ - + +]
    [*0...flip_array.length].each do |item|
        stack[item] = flip_array[item]
    end
    return stack
end

def pancake_flipping(pancakes)
    # first check if the stack is good
    stack = pancakes.split('')
    if !stack.include? "-" then return 0 end
    #stack includes - in the stack. first check if the stack and if the stack has
    #more - then positive flip the whole stack
    stack = check_stack(stack)
    # will use a bubble sort method to check if items need to be flipped.
    counter = 1
    # puts stack.join('')
    while (stack.include? "-") && (counter < stack.length) do
        if stack[counter] != stack[counter - 1]
            stack = flip(stack, counter)
            @flips += 1
            # puts stack.join('')
        end
        counter+= 1
    end
    
    if stack[0] == "-"
        @flips += 1
    end
    
    return @flips
end

tests = gets.chomp.to_i

tests.times do |count|
    @flips = 0
    pancakeStack = gets.chomp
    puts "Case ##{count + 1}: #{pancake_flipping(pancakeStack)}"
end
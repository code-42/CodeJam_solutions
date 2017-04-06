def ovation(input)
    input = input.split(" ")
    maxShy = input[0].to_i
    if maxShy == 0 
        return 0
    end
    crowdstr = input[1].split('')
    crowd = []
    crowdstr.each do |level|
        crowd << level.to_i
    end
    
    if !crowd.include?(0)
        return 0
    end
    counter = 0
    friends = 0
    [*0..maxShy].each do |shyLevel|
        # if counter < maxShy
            if crowd[shyLevel] != 0
                if counter >= shyLevel
                    counter += crowd[shyLevel]
                else
                    friends_to_add = shyLevel - counter
                    counter += friends_to_add
                    friends += friends_to_add
                    counter += crowd[shyLevel]
                end
            end
        # end
        # puts "shylevel: #{shyLevel}, people: #{counter}, friends: #{friends}"
    end while counter < maxShy
    
    return friends
end

def main
    tests = gets.chomp.to_i
    [*1..tests].each do |case_num|
        puts "Case ##{case_num}: #{ovation(gets.chomp)}"
    end
end

main
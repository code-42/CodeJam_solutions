class Element
   @value
   @positive
   
   attr_accessor :value
   attr_accessor :positive
   
   def initialize(value, pos)
       @value = value
       @positive = pos
   end
   

end

def print_elem(elem)
   result = ""
   if !elem.positive
      result += "-"
   end
   result += elem.value
   return result
end
   

def pos(pos1, pos2)
   if pos1.positive == pos2.positive
      return true
   else
      return false
   end
end

def neg(pos1, pos2)
   if pos1.positive == pos2.positive
      return false
   else
      return true
   end
end

def quaternion(elem1, elem2)
   result = Element.new("0", true)
   case elem1.value
   when "1"
      return Element.new(elem2.value, pos(elem1, elem2))
   when "i"
      case elem2.value
      when "1"
         # standard result i
         return Element.new("i", pos(elem1, elem2))
      when "i"
         return Element.new("1", neg(elem1, elem2))
      when "j"
         # standard result k
         return Element.new("k", pos(elem1, elem2))
      when "k"
         # standard result -j
         return Element.new("j", neg(elem1, elem2))
      end
   when "j"
      case elem2.value
      when "1"
         # j * 1 = j
         return Element.new("j", pos(elem1, elem2))
      when "i"
         # j * i = -k
         return Element.new("k", neg(elem1, elem2))
      when "j"
         # j * j = -1
         return Element.new("1", neg(elem1, elem2))
      when "k"
         # j * k = i
         return Element.new("i", pos(elem1, elem2))
      end
   when "k"
      case elem2.value
      when "1"
         # k * 1 = k
         result.value = "k"
         return Element.new("k", pos(elem1, elem2))
      when "i"
         # k * i = j
         result.value = "j"
         return Element.new("j", pos(elem1, elem2))
      when "j"
         # k * j = -i
         result.value = "i"
         return Element.new("i", neg(elem1, elem2))
      when "k"
         # k * k = -1
         result.value = "1"
         return Element.new("1", neg(elem1, elem2))
      end
   else
      puts "elem1: #{print_elem(elem1)} elem2: #{print_elem(elem2)}"
      puts "error"
   end
   puts "result #{print_elem(result)}"
   return result
end

def initial_check(elements)
   value = Element.new("1", true)
   
   [*0...elements.length].each do |elem|
      value = quaternion(value, elements[elem])
   end
   
   return print_elem(value)
end

def find_i_and_j(elements)
   i_value = Element.new("1", true)
   j_value = Element.new("1", true)
   
   counter = 0
   while (counter < elements.length) && (print_elem(i_value) != "i" || print_elem(j_value) != "j")  do
      if print_elem(i_value) != "i"
         i_value = quaternion(i_value, elements[counter])
      elsif print_elem(j_value) != "j"
         j_value = quaternion(j_value, elements[counter])
      end
      counter += 1
   end
   return (print_elem(i_value) == "i") && (print_elem(j_value) == "j")
end
   
   
def i_got_it_right
   inputs = gets.chomp.split(" ")
   length = inputs[0].to_i
   times = inputs[1].to_i
   string = (gets.chomp * times).split('')
   
   if string.length < 3 
      return "NO"
   end
   if string.length == 3
      if string.join('') == "ijk"
         return "YES"
      else
         return "NO"
      end
   end
   
   elements = []
   string.each do |elem|
      elements << Element.new(elem, true)
   end
   
   if initial_check(elements) == "-1"
      if find_i_and_j(elements)
         return "YES"
      else
         return "NO"
      end
   else
      return "NO"
   end
   
end

def main
   tests = gets.chomp.to_i
   
   [*1..tests].each do |case_num|
      puts "Case ##{case_num}: #{i_got_it_right}"
   end
end

main
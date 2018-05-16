# input: arr, delimeter, final_delimeter
# output: string with elements delimited by the above

# save array size
# construct empty string
# for each element in array, push el + delimiter to string
#   unless it's the penultimate el, in which case also add final delimeter
#     then add final el
#     exception for 2 item array, when it is just joined by final delimeter

# delim defaults to ,
# final_delim defaults to 'or'

# def joinor(arr, delim = ', ', final_delim = 'or')
#   return "#{arr[0]}" if arr.size < 2
#   return "#{arr[0]} #{final_delim} #{arr[1]}" if arr.size == 2

#   final_index = arr.size - 1
#   output = ''

#   arr.each_with_index do |el, i|
#     output += i < final_index ? "#{el}#{delim}" : "#{final_delim} #{el}"
#   end

#   output
# end

# cleaner to use Array#join !!
def joinor(arr, delim = ', ', final_delim = 'or')
  case arr.size
  when 0 then ''
  when 1 then "#{arr.first}"
  when 2 then arr.join(" #{final_delim} ")
  else
    arr[-1] = "#{final_delim} #{arr.last}"
    arr.join(delim)
  end
end

p joinor([4])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"


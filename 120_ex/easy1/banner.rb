# class Banner
#   def initialize(message)
#     @message = message
#     @length = message.length
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-#{'-' * @length}-+"
#   end

#   def empty_line
#     "| #{' ' * @length} |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner2 = Banner.new('')
# puts banner2
# +--+
# |  |
# |  |
# |  |
# +--+

# further exploration: specify optional banner width
# - message centered within width
# - if too narrow for message, wrap and center second line

# works, but does not wrap on word... try below with regexp
# class Banner
#   def initialize(message, width = message.length + 4)
#     @message = message
#     @banner_width = width >= 4 ? width : 4
#     @available_message_width = @banner_width - 4
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-#{'-' * @available_message_width}-+"
#   end

#   def empty_line
#     "| #{' ' * @available_message_width} |"
#   end

#   def message_line
#     if @message.length <= @available_message_width
#       "| #{@message.center(@available_message_width)} |"
#     else
#       wrap_message
#     end
#   end

#   def wrap_message
#     return "|  |" if @available_message_width < 1

#     lines_array = []

#     until @message.empty?
#       lines_array << @message.slice!(0...@available_message_width)
#     end

#     lines_array.each_with_object([]) do |line, arr|
#       arr << "| #{line.center(@available_message_width)} |"
#     end
#   end
# end

#   #regexp messes up if no spaces, and needs to deal better with punctuation...
# RATHER THAN USING WORD BOUNDARY, HOW ABOUT DOING X-ANYTHINGS FOLLOWED BY SPACES/END OF STR ...
# (SEE IVAN DURAN IF YOU CAN'T FIGURE IT OUT) NOTE THAT MOST PEOPLE ARE USING
# GSUB AND BACKREFERENCES...

require 'pry'
require 'pry-byebug'
class Banner
  def initialize(message, width = message.length + 4)
    @message = message
    @banner_width = width >= 4 ? width : 4
    @available_message_width = @banner_width - 4
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @available_message_width}-+"
  end

  def empty_line
    "| #{' ' * @available_message_width} |"
  end

  def message_line
    if @message.length <= @available_message_width
      "| #{@message.center(@available_message_width)} |"
    else
      wrap_message
    end
  end

  def wrap_message
    return "|  |" if @available_message_width < 1
    # binding.pry
    lines_array = []

    # THIS GETTING LOLDICROUS...!
    until @message.empty?
      lines_array << @message.slice!(/(\A(.{0,#{@available_message_width - 1}})(\s|\z)) | (\A.{0,#{@available_message_width}})/)
    end

    lines_array.each_with_object([]) do |line, arr|
      arr << "| #{line.center(@available_message_width)} |"
    end
  end
end


banner1 = Banner.new('To boldly go where no one has gone before.', 40)
puts banner1

banner2 = Banner.new('ten_ chars!', 9)
puts banner2

# # banner3 = Banner.new('', 0)
# # puts banner3
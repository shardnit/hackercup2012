=begin
  Some engineers got tired of dealing with all the different ways of encoding status messages, so they decided to invent their own. In their new scheme, an encoded status message consists of a sequence of integers representing the characters in the message, separated by spaces. Each integer is between 1 and M, inclusive. The integers do not have leading zeroes. Unfortunately they decided to compress the encoded status messages by removing all the spaces!
Your task is to figure out how many different encoded status messages a given compressed status message could have originally been. Because this number can be very large, you should return the answer modulo 4207849484 (0xfaceb00c in hex).
  For example, if the compressed status message is "12" it might have originally been "1 2", or it might have originally been "12". The compressed status messages are between 1 and 1000 characters long, inclusive. Due to database corruption, a compressed status may contain sequences of digits that could not result from removing the spaces in an encoded status message.
                 Input
The input begins with a single integer, N, the number of compressed status messages you must analyze. This will be followed by N compressed status messages, each consisting of an integer M, the highest character code for that database, then the compressed status message, which will be a string of digits each in the range '0' to '9', inclusive. All tokens in the input will be separated by some whitespace.
  Output
For each of the test cases numbered in order from 1 to N, output "Case #i: " followed by a single integer containing the number of different encoded status messages that could be represented by the corresponding compressed sequence modulo 4207849484. If none are possible, output a 0.
  Constraints
5 <= N <= 25
2 <= M <= 255
1 <= length of encoded status <= 1000
=end
def test(j, i, highest_code, encoded_status)
  sum = 0
  for k in j..i
    sum = sum*10
    sum = sum+encoded_status[k].chr.to_i
  end

  sum<=highest_code ? true : false
end

def total_messages(highest_code, encoded_status, case_no)
  table = Array.new(encoded_status.strip.length+1, 0)
  table[0]=1
  n = encoded_status.strip.length

  for i in 0...n
    j = i
    while j>=0
      if encoded_status[j].chr.to_i!=0
        if not test(j, i, highest_code, encoded_status)
          j = j-1
          break
        else
          table[i+1] = (table[i+1]+table[j])%4207849484
          j = j-1
        end
      else
        j = j-1
      end
    end
  end
  p table
  puts "Case ##{case_no}: #{table[n]}"

end

@whitespace_flag = false
highest_code = 0
encoded_status = ''
case_no = 1

File.open(ARGV[0]).each_with_index do |line, index|
    if index == 0
      @total_tests = line.to_i
      if @total_tests <5 and @total_tests > 25
        exit
      end
    else
      if @whitespace_flag == false
        info = line.split(' ')
        if info.length == 2
          highest_code = info[0].to_i
          encoded_status = info[1]
          puts "highest_code: #{highest_code} encoded_status: #{encoded_status}"
          total_messages(highest_code, encoded_status, case_no)
          case_no += 1
        else
          highest_code = info[0].to_i
          @whitespace_flag = true
          next
        end
      else
        encoded_status = line
        @whitespace_flag = false
        puts "highest_code: #{highest_code} encoded_status: #{encoded_status}"
        total_messages(highest_code, encoded_status, case_no)
        case_no += 1
      end

    end
end

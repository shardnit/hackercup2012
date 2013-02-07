=begin
A double-square number is an integer X which can be expressed as the sum of two perfect squares. For example, 10 is a double-square because 10 = 32+ 12. Your task in this problem is, given X, determine the number of ways in which it can be written as the sum of two squares. For example, 10 can only be written as 32 + 12 (we don’t count 12 + 32 as being different). On the other hand, 25 can be written as 52 + 02 or as 42 + 32.

  Input

You should first read an integer N, the number of test cases. The next N lines will contain N values of X.

  Constraints

0 â‰¤ X â‰¤ 2147483647
1 â‰¤ N â‰¤ 100

Output

For each value of X, you should output the number of ways to write X as the sum of two squares.

  Example input

5
10
25
3
0
1

Example output

1
2
0
1
1
=end

File.open(ARGV[0]).each_with_index do |line, index|
  if index == 0
    @total_tests = line
  else
    number = line.to_i
    number_sqrt = Math.sqrt(number.to_i).to_i
    min = 0
    max = number_sqrt
    output = 0

    while min<=max
      square_result = min**2 + max **2
      if square_result == number
        output += 1
        max = max - 1
      elsif square_result > number
        max = max - 1
      elsif square_result < number
        min = min + 1
      end
    end
    puts "Case ##{index}: #{output}"
  end
end

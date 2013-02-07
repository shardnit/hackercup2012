=begin
  We are starting preparations for Hacker Cup 2013 really early. Our first step is to prepare billboards to advertise the contest. We have text for hundreds of billboards, but we need your help to design them.

  The billboards are of different sizes, but are all rectangular. The billboard widths and heights are all integers. We will supply you with the size in inches and the text we want printed. We want you to tell us how large we can print the text, such that it fits on the billboard without splitting any words across lines. Since this is to attract hackers like yourself, we will use a monospace font, meaning that all characters are of the same width (e.g.. 'l' and 'm' take up the same horizontal space, as do space characters). The characters in our font are of equal width and height, and there will be no additional spacing between adjacent characters or adjacent rows.

  Let's say we want to print the text "Facebook Hacker Cup 2013" on a 350x100" billboard. If we use a font size of 33" per character, then we can print "Facebook" on the first line, "Hacker Cup" on the second and "2013" on the third. The widest of the three lines is "Hacker Cup", which is 330" wide. There are three lines, so the total height is 99". We cannot go any larger.

  Input
The first line of the input file contains a single integer T: the number of test cases. T lines follow, each representing a single test case in the form "W H S". W and H are the width and height in inches of the available space. S is the text to be written.

  Output
Output T lines, one for each test case. For each case, output "Case #t: s", where t is the test case number (starting from 1) and s is the maximum font size, in inches per character, we can use. The size must be an integral number of inches. If the text does not fit when printed at a size of 1", then output 0.

  Constraints
1 <= T <= 20
1 <= W, H <= 1000
The text will contain only lower-case letters a-z, upper-case letters A-Z, digits 0-9 and the space character
The text will not start or end with the space character, and will never contain two adjacent space characters
The text in each case contains at most 1000 characters
=end

class Billboard
  def initialize(filename)
    @input_file = filename
    @total_tests
  end
  def does_it_fit(width, height, text, font_size)
    text = text.split(' ')
    num_of_spaces = text.count - 1

    lines = 1
    sum = 0
    i = 0
    while i != (text.count)
      if sum == 0
        if((sum+((text[i].size)*font_size)) > width)
          # if sum is zero and even if current word cant fit in the current
          # line then return false
          return false
        else
          sum += text[i].size*font_size
          i += 1
        end
      else
        if((sum+((text[i].size+1)*font_size)) > width)
          sum = 0
          lines +=1
        else
          sum += (text[i].size+1)*font_size
          i += 1
        end
      end
    end

    puts "LINE: #{lines}"
    return (lines*font_size)>height ? false : true
  end

  def billboard_font
    File.open(@input_file).each_with_index do |line, index|
      if index == 0
        @total_tests = line.to_i
      else
        font_size = 0
        test_case = line.split(' ')
        width = test_case[0].to_i
        height = test_case[1].to_i
        text = test_case[2..test_case.count].join(" ")
        final = 0
        puts text

        if index > @total_tests or width > 1000 or height > 1000 or index > 20 or text.length>1000
          return false
        end

        #max = width>height ? width : height
        min = 0
        max = width

        while min != max
          if min == max -1
            min = max
          end
          puts "MIN: #{min} MAX: #{max}"
          font_size = ((min+max)/2)
          puts "FONT SIZE: #{font_size}"
          if does_it_fit(width, height, text, font_size)
            min = font_size
            final = min
          else
            max = font_size
          end
        end
        File.open('output', 'a+') {|f| f.write("Case ##{index}: #{final}\n")}
      #break
      end
    end
  end
end

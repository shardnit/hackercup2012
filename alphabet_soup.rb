=begin
ALPHABET SOUP
Alfredo Spaghetti really likes soup, especially when it contains alphabet pasta. Every day he constructs a sentence from letters, places the letters into a bowl of broth and enjoys delicious alphabet soup.

  Today, after constructing the sentence, Alfredo remembered that the Facebook Hacker Cup starts today! Thus, he decided to construct the phrase "HACKERCUP". As he already added the letters to the broth, he is stuck with the letters he originally selected. Help Alfredo determine how many times he can place the word "HACKERCUP" side-by-side using the letters in his soup.

  Input
  The first line of the input file contains a single integer T: the number of test cases. T lines follow, each representing a single test case with a sequence of upper-case letters and spaces: the original sentence Alfredo constructed.

  Output
  Output T lines, one for each test case. For each case, output "Case #t: n", where t is the test case number (starting from 1) and n is the number of times the word "HACKERCUP" can be placed side-by-side using the letters from the sentence.

  Constraints
  1 < T < 20
  Sentences contain only the upper-case letters A-Z and the space character
  Each sentence contains at least one letter, and contains at most 1000 characters, including spaces
=end
File.open(ARGV[0]).each_with_index do |line, index|
  if index == 0
    @total_tests = line.to_i
  else
    sentence = line
    word = 'HACKERCUP'

    if index > @total_tests or index > 20 or sentence.length > 1000
      next
    end

    alphabets = Array.new(256, 0)

    for i in (0...sentence.length)
      if sentence[i] == ' '
        next
      else
        alphabets[sentence[i]] += 1
      end
    end

    result = sentence.size

    for i in (0...word.length)
      result = alphabets[word[i]] < result ? alphabets[word[i]] : result
    end

    result = result < (alphabets[?C]/2) ? result : (alphabets[?C]/2)
    File.open('output_soup', 'a+') {|f| f.write("Case ##{index}: #{result}\n")}
  end
end

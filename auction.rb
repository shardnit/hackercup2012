=begin
AUCTIONS
You have encountered a new fancy online auction that offers lots of products. You are only interested in their price and weight. We shall say that product A is strictly preferred over product B if A costs less than B and is not heavier (they may be of equal weight) or if A weighs less and is not more expensive (they can have equal price).

  We shall call a product A a bargain if there is no product B such that B is better than A. Similarly, we shall call a product C a terrible deal if there exists no product D such that C is better than D. Note that according to our definitions, the same product may be both a bargain and a terrible deal! Only wacky auctioneers sell such products though.

  One day you wonder how many terrible deals and bargains are offered. The number of products, N, is too large for your human-sized brain though. Fortunately, you discovered that the auction manager is terribly lazy and decided to sell the products based on a very simple pseudo-random number generator.

  If product i has price Pi and weight Wi, then the following holds for product i+1:

  Pi = ((A*Pi-1 + B) mod M) + 1 (for all i = 2..N)
Wi = ((C*Wi-1 + D) mod K) + 1 (for all i = 2..N)
You carefully calculated the parameters for the generator (P1, W1, M, K, A, B, C and D). Now you want to calculate the number of terrible deals and bargains on the site.

  Input
The first line of the input file contains a single integer T: the number of test cases. T lines follow, each representing a single test case with 9 space-separated integers: N, P1, W1, M, K, A, B, C and D.

  Output
Output T lines, one for each test case. For each case, output "Case #t: a b", where t is the test case number (starting from 1), a is the number of terrible deals and b is the number of bargains.

  Constraints
1 <= T <= 20
1 <= N <= 10^18
1 <= M, K <= 10^7
1 <= P1 <= M
1 <= W_1 <= K
0 <= A,B,C,D <= 10^9
=end

def is_bargain(p1, w1, p2, w2)
  # its a bargain if product2 is not better then product1
  # which can be tested if product2 has either more cost
  # or more weight
  if p2 > p1 or  w2 > w1
    return true
  elsif p2==p1 and w2 == w1
    return true
  else
    return false
  end
end

def is_terrible(p1, w1, p2, w2)
  # product1 is not better than product 2
  # if either its overly priced or overly weight
  if p1 > p2 or w1 > w2
    return true
  elsif p1==p2 and w1 == w2
      return true
  else
    return false
  end
end

def calculate_price(n, a, p1, b, m)
  previous_price = p1
  for i in (1..n)
    previous_price = ((a*previous_price + b) % m) + 1
  end
  return previous_price
end

def calculate_weight(n, c, w1, d, k)
  previous_weight = w1
  for i in (1..n)
    previous_weight = ((c*previous_weight + d) % k) + 1
  end
  return previous_weight
end

File.open(ARGV[0]).each_with_index do |line, index|
  if index == 0
    @total_tests = line.to_i
  else
    input = line.split(' ')
    n = input[0].to_i
    p1 = input[1].to_i
    w1 = input[2].to_i
    m = input[3].to_i
    k = input[4].to_i
    a = input[5].to_i
    b = input[6].to_i
    c = input[7].to_i
    d = input[8].to_i

    if  n > 10**18 or k > 10**7 or m > 10**7 or p1>m or w1 > k or a > 10**9
      next
    end

    terribles = 0
    bargains = 0
#    price_array = Array.new(n, 0)
#    weight_array = Array.new(n, 0)
#
#    price_array[0] = p1
#    weight_array[0] = w1
#
#    for i in (1...n)
#      price_array[i] = ((a*price_array[i-1] + b) % m) + 1
#      weight_array[i] = ((c*weight_array[i-1] + d) % k) + 1
#    end
#    p price_array
#    p weight_array
#    puts "#######"
#    for i in (1...n)
#      price_array[i] = calculate_price(i, a, p1, b, m)
#      weight_array[i] = calculate_weight(i, c, w1, d, k)
#    end
#
#    p price_array
#    p weight_array
#    puts "*****************"

    for i in (0...n)
      bargain_count = 0
      terrible_count = 0
      for j in (0...n)
        if i==j
          next
        else
          price_i = calculate_price(i, a, p1, b, m)
          price_j = calculate_price(j, a, p1, b, m)

          weight_i = calculate_weight(i, c, w1, d, k)
          weight_j = calculate_weight(j, c, w1, d, k)

          if is_bargain(price_i, weight_i, price_j, weight_j)
            bargain_count +=1
          end

          if is_terrible(price_i, weight_i, price_j, weight_j)
            terrible_count += 1
          end
        end
      end
      if bargain_count == n-1
        bargains += 1
      end
      if terrible_count== n-1
        terribles += 1
      end
    end

    File.open('output_auction', 'a+') {|f| f.write("Case ##{index}: #{terribles} #{bargains}\n")}
  end
end


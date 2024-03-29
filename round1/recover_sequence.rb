=begin
Merge sort is one of the classic sorting algorithms. It divides the input array into two halves, recursively sorts each half, then merges the two sorted halves.
In this problem merge sort is used to sort an array of integers in ascending order. The exact behavior is given by the following pseudo-code:

function merge_sort(arr):
    n = arr.length()
    if n <= 1:
        return arr

    // arr is indexed 0 through n-1, inclusive
    mid = floor(n/2)

    first_half = merge_sort(arr[0..mid-1])
    second_half = merge_sort(arr[mid..n-1])
    return merge(first_half, second_half)

function merge(arr1, arr2):
    result = []
    while arr1.length() > 0 and arr2.length() > 0:
        if arr1[0] < arr2[0]:
            print '1' // for debugging
            result.append(arr1[0])
            arr1.remove_first()
        else:
            print '2' // for debugging
            result.append(arr2[0])
            arr2.remove_first()

    result.append(arr1)
    result.append(arr2)
    return result
A very important permutation of the integers 1 through N was lost to a hard drive failure. Luckily, that sequence had been sorted by the above algorithm and the debug sequence of 1s and 2s was recorded on a different disk. You will be given the length N of the original sequence, and the debug sequence. Recover the original sequence of integers.
Input
The first line of the input file contains an integer T. This is followed by T test cases, each of which has two lines. The first line of each test case contains the length of the original sequence, N. The second line contains a string of 1s and 2s, the debug sequence produced by merge sort while sorting the original sequence. Lines are separated using Unix-style ("\n") line endings.
Output
To avoid having to upload the entire original sequence, output an integer checksum of the original sequence, calculated by the following algorithm:

function checksum(arr):
    result = 1
    for i=0 to arr.length()-1:
        result = (31 * result + arr[i]) mod 1000003
    return result
Constraints
5 ≤ T ≤ 20
2 ≤ N ≤ 10000
Examples
In the first example, N is 2 and the debug sequence is 1. The original sequence was 1 2 or 2 1. The debug sequence tells us that the first number was smaller than the second so we know the sequence was 1 2. The checksum is 994.
In the second example, N is 2 and the debug sequence is 2. This time the original sequence is 2 1.
In the third example, N is 4 and the debug sequence is 12212. The original sequence is 2 4 3 1.
=end
def checksum(arr)
  result = 1
  for i in  (0..(arr.length-1))
    result = (31 * result + arr[i]) % 1000003
  end
  return result
end
def merge_sort(arr, debug_sequence)
  n = arr.length.to_f
  if n <= 1
    return arr
  end
  mid = (n/2).floor

  first_half = merge_sort(arr[0..mid-1], debug_sequence)
  second_half = merge_sort(arr[mid..n-1], debug_sequence)
  return merge(first_half, second_half, debug_sequence)
end

def merge(arr1, arr2, debug_sequence)
  result = []
  while arr1.length > 0 and arr2.length > 0
    #if (arr1[0] < arr2[0])
    if (debug_sequence[0] == 1)
     # puts '1' # for debugging
      result<<arr1[0]
      arr1.delete_at(0)
      debug_sequence.delete_at(0)
    else
     # puts '2' # for debugging
      result<<arr2[0]
      arr2.delete_at(0)
      debug_sequence.delete_at(0)
    end
  end
  if arr1.length>0
    for i in (0...arr1.length)
      result<<arr1[i]
    end
  end
  if arr2.length>0
    for i in (0...arr2.length)
      result<<arr2[i]
    end
  end
  return result
end
def original_sequence(length, debug_sequence, case_no)
    sequence_arr = []
    arr_debug_sequence = []
    original_seq = []
    temp = []
    for i in (1..length)
      sequence_arr<<i
    end
    for i in (0...debug_sequence.length)
      arr_debug_sequence << debug_sequence[i].chr.to_i
    end
     temp = merge_sort(sequence_arr, arr_debug_sequence)
      for i in (0...length)
        original_seq[temp[i] - 1] = sequence_arr[i]
      end
      p checksum(original_seq)

end
flag = false
case_no = 1
length = 0
original_sequence = ''
File.open(ARGV[0]).each_with_index do |line, index|
  if index == 0
    total_cases = line.to_i
  else
    if flag == false
      length = line.to_i
      flag = true
    else
      debug_sequence = line.strip
      flag = false
      original_sequence(length, debug_sequence, case_no)
      case_no +=1
    end
  end
end

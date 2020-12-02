module Enumerable
  def my_each
    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    my_each { |x| result << x if yield(x) }
    result
  end

  def my_all?(*)
    unless block_given?
      my_each { |i| return false if i.nil? || i == false }
      return true
    end
    count = 0
    my_each { |i| count += 1 if yield(i) }
    count == length
  end

  def my_any?(number = 0)
    unless block_given?
      if number.instance_of?(Class)
        my_each { |x| return true if x.is_a? number }
      elsif number.instance_of?(Regexp)
        my_each { |x| return true if number.match?(x.to_s) }
      elsif [nil, false].include?(number)
        my_each { |x| return true if x == number }
      end
      return false
    end
    my_each { |x| return true if yield(x) }
    false
  end

  def my_none?(*arg)
    unless block_given?
      if arg.instance_of?(Regexp)
        my_each { |x| return false if arg.match?(x.to_s) }
      elsif arg.instance_of?(Class)
        my_each { |x| return false if x.is_a? arg }
      else
        my_each { |x| return false if x }
      end
      return true
    end
    my_each { |i| return false if yield(i) }
    true
  end
end

puts '1.--------my_each--------'
%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend }
puts '2.--------my_each_with_index--------'
%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? }
puts '3.--------my_select--------'
puts(%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })
puts '4.--------my_all--------'
puts(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
puts %w[ant bear cat].my_all?(/t/) #=> false
puts [1, 2i, 3.14].my_all?(Numeric) #=> true
puts [].my_all? #=> true
puts '5.--------my_any--------'
puts(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false
puts '6.--------my_none--------'
puts(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
puts(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
puts %w[ant bear cat].my_none?(/d/) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false

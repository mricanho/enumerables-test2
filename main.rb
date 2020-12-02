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
  def my_count(*arg)
    count = 0
    unless block_given?
      if include?(arg)
        my_each { |x| count += 1 if x == arg }
        return count
      end
      return arg.length
    end
    my_each { |x| count += 1 if yield(x) }
    count
  end
end

array = [2, 52, 6, 9, 6, 14, 10, 30, 5]
arrays = ["yes", "no", 9, "maybe", nil, "I don't know", 85.5]
array.my_each { |x| puts x ** 2 }
arrays.my_each_with_index {|value, index| puts "#{index} item is #{value};" }
array.my_select { |x| p x.odd? }
arrays.my_any? { |x| puts x.is_a? Numeric }
puts array.my_count {|x| x < 10}
p array.my_map {|x | x * 2 }
p array.my_inject(0, :+)

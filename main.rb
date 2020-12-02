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
end

puts '1.--------my_each--------'
%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend }
puts '2.--------my_each_with_index--------'
%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? }
puts '3.--------my_select--------'
puts (%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })
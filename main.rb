def bubble_sort(arr)
  number_ofloop = arr.length - 1
  (0..number_ofloop).each do
    (0...number_ofloop).each do |j|
      arr[j], arr[j + 1] = arr[j + 1], arr[j] if arr[j] > arr[j + 1]
    end
  end
  arr
end

# The second:

def bubble_sort_by(arr)
  number_ofloop = arr.length - 1 # loop inside the index not the length
  (0..number_ofloop).each do
    (0...number_ofloop).each do |j|
      arr[j], arr[j + 1] = arr[j + 1], arr[j] if yield(arr[j], arr[j + 1]).positive?
    end
  end
  arr
end

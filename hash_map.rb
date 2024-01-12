class HashMap
  attr_accessor :buckets, :capacity
  def initialize
    @buckets = Array.new(16)
    @capacity = 16
  end

  def hash(string)
    string_to_number(string)
  end

  def string_to_number(string)
    hash_code = 0
    prime_number = 31
  
    string.each_char { |char| hash_code = prime_number * hash_code + char.ord }
  
    hash_code
  end
  
  def load_factor_reached?
    load_factor = 0.75
    occupied = self.length.to_f
    capacity = @capacity
    result = occupied / capacity
    return true if result.round(2) >= load_factor
    false
  end

  def resize_array
    new_array = Array.new(@capacity)
    self.buckets = self.buckets + new_array
    update_capacity
  end

  def update_capacity
    new_capacity = @capacity + @capacity
    @capacity = new_capacity
  end

  def clear
    new_array = Array.new(self.buckets.length)
    self.buckets.replace(new_array)
  end

  def length
    count = 0
    self.buckets.each do |bucket|
     next if bucket.nil?
     count += bucket.count_keys
    end
    count
  end

  def remove(key)
    index = hash(key) % @capacity
    @buckets[index].delete(key)
  end

  def get(key)
    index = hash(key) % @capacity
    @buckets[index].get_value(key)
  end

  def set(key = rand(1000).to_s, value = rand(100).to_s)
  index = hash(key) % @capacity
  raise IndexError if index.negative? || index >= @buckets.length
  resize_array if load_factor_reached?
  if @buckets[index].nil?
    list = LinkedList.new
    node = Node.new(key,value)
    list.append(node)
    @buckets[index] = list
  elsif !@buckets[index].nil? && !self.key?(key,index)
    node = Node.new(key,value)
    @buckets[index].append(node)
  else
    @buckets[index].replace_value(key, value)
  end
end


def key?(key,index)
 @buckets[index].key_exist?(key)
end

end

class Node
  attr_accessor :key, :value,:next_node
  def initialize(key=nil,value=nil)
    @key = key
    @value = value
    @next_node = nil
  end
end

class LinkedList
  attr_accessor :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def append(node = Node.new) 
    if @head.nil?
      @head = node
    elsif !@head.nil? && @tail.nil?
      @head.next_node = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def delete(key)
    current = self.head
    return @head = current.next_node if current.key == key
    while current.next_node.key != key
      current = current.next_node
      return "no key found." if current.next_node == nil
    end
    if current.next_node == @tail
      @tail = current
    return  @tail.next_node = nil
  else
    back_chain = current
    2.times{ current = current.next_node }
    back_chain.next_node = current
    end
  end

  def key_exist?(key)
    current = self.head
    while current do
      return true if current.key == key
      current = current.next_node
    end
    false
  end

  def get_value(key)
    current = self.head
    while current
      return current.value if current.key == key
      current = current.next_node
    end
  end

  def replace_value(key, value)
    current = self.head
    while current
      return current.value = value if current.key == key
      current = current.next_node
    end
  end

  def count_keys
    count = 0
    current = self.head
    while current
      count+=1
      current = current.next_node
    end
    count
  end

end




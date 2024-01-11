class HashMap
  attr_accessor :buckets
  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.75

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

  def length
    self.buckets.each do |bucket|
      puts bucket
    end
  end

  def remove(key)
    index = hash(key) % 16
    @buckets[index].delete(key)
  end

  def get(key)
    index = hash(key) % 16
    @buckets[index].get_value(key)
  end

  def set(key,value)
  index = hash(key) % 16
  raise IndexError if index.negative? || index >= @buckets.length
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

end


hash_map = HashMap.new

hash_map.set('string','abcd')
hash_map.set('strrr', 'value')
25.times{hash_map.set("#{rand(100)}",'value')}
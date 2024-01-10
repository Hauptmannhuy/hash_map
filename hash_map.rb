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

  def set(key,value)
  index = hash(key) % 16
  if @buckets[index].nil?
    list = LinkedList.new
    node = Node.new(key,value)
    list.append(node)
    @buckets[index] = list
  elsif !@buckets[index].nil? && !self.key?(key,index)
    node = Node.new(key,value)
    @buckets[index].append(node)
  else
    list_head = @buckets[index].head
    @buckets[index].replace_value(key, value, list_head)
  end
end


def key?(key,index)
  list_head = @buckets[index].head
 @buckets[index].find_key(key, list_head)
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

  def find_key(key, head)
    current = head
    while current do
      return true if current.key == key
      current = current.next_node
    end
    false
  end

  def replace_value(key, value, head)
    current = head
    while current
      return current.value = value if current.key == key
      current = current.next_node
    end
  end

end


hash_map = HashMap.new

hash_map.set('string','abcd')
hash_map.set('strrr', 'value')

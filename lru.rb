class Node
  def initialize(val, key = nil, _next=nil, prev= nil)
    @val = val
    @key = key
    @next = _next
    @prev = prev
  end
  attr_accessor :val, :key, :next , :prev
end

class DB
  def initialize(head= nil, tail= nil)
    @head = head
    @tail = tail
  end
  attr_accessor :head, :tail

  def add_to_head(node)
    if head
      node.next = head
      head.prev = node
    end
    self.tail = node if tail.nil?
    self.head = node
  end

  def unlink(node)
    prev = node.prev
    next_node = node.next
    prev.next = next_node if prev
    next_node.prev = prev if next_node
    self.head = next_node if head == node
    self.tail = prev if tail == node
    node.prev = nil
    node.next = nil
  end

  def evict
    node = tail
    unlink(node)
    node
  end

  def touch(node)
    unlink(node)
    add_to_head(node)
  end
end


class LRUCache

=begin
    :type capacity: Integer
=end
  def initialize(capacity)
    @capacity = capacity
    @db = DB.new
    @keys = {}
    @size = 0
  end
  attr_accessor :capacity, :db, :size, :keys


=begin
    :type key: Integer
    :rtype: Integer
=end
  def get(key)
    if keys[key]
      node = keys[key]
      db.touch(node)
      node.val
    else
      -1
    end
  end


=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
  def put(key, value)
    if keys[key]
      node = keys[key]
      db.unlink(node)
      node.val = value
      db.add_to_head(node)
    else
      node = Node.new(value, key)
      keys[key] = node
      trigger_eviction if size >= capacity
      db.add_to_head(node)
      self.size += 1
    end
  end

  def trigger_eviction
    node = db.evict
    keys.delete(node.key)
    self.size -= 1
  end

end

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache.new(capacity)
# param_1 = obj.get(key)
# obj.put(key, value)
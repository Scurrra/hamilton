require "./any"

# Storage class for `Hamilton::Context`. Basically, it's a hidden `Hash(Symbol, Hamilton::Any)` with overridden
# `[]`, `[]?`, and `[]=` to not need to explicitly convert some type to `Hamilton::Any`.
class Hamilton::Storage
  private property raw : Hash(Symbol, Hamilton::Any)

  # Create an empty `Hamilton::Storage`.
  def initialize
    @raw = Hash(Symbol, Hamilton::Any).new
  end

  # Check if there is a key in the storage. 
  def has_key?(key : Symbol)
    return @raw.has_key?(key)
  end

  # Get value for the `key`. If key does not exist, raises a `KeyError` exception.
  def [](key : Symbol)
    if @raw.has_key?(key)
      return @raw[key]
    else
      raise KeyError.new message: "No key `#{key}` in this `Hamilton::Storage` instance"
    end
  end

  # Get value for the `key`, or nil if it doesn't exist.
  def []?(key : Symbol)
    @raw[key]?
  end

  # Returns the value for the `key`, or when not found the value given by `default`.
  # Raises an `ArgumentError` if something goes wrong (wrong type of `default`).
  def fetch(key : Symbol, default)
    if old_value = @raw[key]?
      return old_value
    end
    value = Hamilton::Any.new(default)
    return value
  end

  # Returns the value for the `key`, or when not found the value returned by the given block invoked with `key`.
  # Raises an `ArgumentError` if something goes wrong (wrong type of block's result).
  def fetch(key : Symbol, &)
    default = yield key
    fetch key, default
  end

  # Assignes `value` to a `key`. Raises an `ArgumentError` if something goes wrong (wrong type of `value`).
  def []=(key : Symbol, value)
    begin
      @raw[key] = Hamilton::Any.new(value)
      return value
    rescue
      # I assume that no other errors could be found
      raise ArgumentError.new message: "Data in `Hamilton::Storage` should be convertible to type `Hamilton::Any` (*similar* to `JSON::Any`), but got #{typeof(value)}"
    end
  end

  # Tries to set `value` to a `key`. Raises an `ArgumentError` if something goes wrong (wrong type of `value`).
  # 
  # If a value already exists for `key`, that (old) value is returned.
  # Otherwise the given block is invoked with `key` and its value is returned.
  def put(key : Symbol, value, &)
    value = Hamilton::Any.new(value)
    if old_value = @raw[key]?
      @raw[key] = value
      return old_value
    end
    @raw[key] = value
    yield key
  end

  # Tries to set `value` to a `key` if it's absent yet. Raises an `ArgumentError` if something goes wrong (wrong type of `value`).
  # 
  # If a value already exists for `key`, that (old) value is returned.
  # Otherwise `value` is returned.
  def put_if_absent(key : Symbol, value)
    if old_value = @raw[key]?
      return old_value
    end
    value = Hamilton::Any.new(value)
    @raw[key] = value
    @raw[key]
  end

  # Tries to set the result of the given block to a `key` if it's absent yet. 
  # Raises an `ArgumentError` if something goes wrong (wrong type of block's result).
  # 
  # If a value already exists for `key`, that (old) value is returned.
  # Otherwise the given block is invoked with `key` and its value is returned.
  def put_if_absent(key : Symbol, & : Symbol ->)
    if old_value = @raw[key]?
      return old_value
    end
    value = yield key
    value = Hamilton::Any.new(value)
    @raw[key] = value
    @raw[key]
  end

  # Get size of the storage.
  def size
    @raw.size
  end

  # Returns `true` when hash contains no key-value pairs.
  def empty?
    @raw.size == 0
  end

  # Get all keys in the storage. 
  def keys
    @raw.keys
  end

  # Get all values in the storage.
  def values
    @raw.values
  end

  # Deletes the key-value pair and returns the value, otherwise returns `nil`.
  def delete(key : Symbol)
    @raw.delete(key)
  end

  # Deletes the key-value pair and returns the value, else yields key with given block.
  def delete(key : Symbol, & : Symbol ->)
    if old_value = @raw[key]?
      @raw.delete(key)
      return old_value
    end
    yield key
  end

  # Empties the storage and returns it.
  def clear : self
    @raw.clear
    self
  end

  def each(&block : {Symbol, Hamilton::Any} ->) : Nil
    @raw.each(&block)
  end

  # Returns an `Array` of `Tuple(Symbol, Hamilton::Any)` with keys and values belonging to this Storage.
  def to_a
    @raw.to_a    
  end

  # :nodoc:
  def to_json(json : JSON::Builder) : Nil
    raw.to_json(json)
  end

  # :nodoc:
  def to_yaml(yaml : YAML::Nodes::Builder) : Nil
    raw.to_yaml(yaml)
  end
end
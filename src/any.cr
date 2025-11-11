# Disclaimer: this is a modified version of Crystal's `JSON::Any`, that is mutable.

# `Hamilton::Any` is a convenient wrapper around all possible JSON types (`Hamilton::Any::Type`)
# and can be used for traversing dynamic or unknown JSON structures.
#
# Note that methods used to traverse a JSON structure, `#[]` and `#[]?`,
# always return a `Hamilton::Any` to allow further traversal. To convert them to `String`,
# `Int32`, etc., use the `as_` methods, such as `#as_s`, `#as_i`, which perform
# a type check against the raw underlying value. This means that invoking `#as_s`
# when the underlying value is not a String will raise: the value won't automatically
# be converted (parsed) to a `String`. There are also nil-able variants (`#as_i?`, `#as_s?`, ...),
# which return `nil` when the underlying value type won't match.
#
# NOTE: this type is a modified version of `JSON::Any`, with a main difference that he underlying data is mutable.
# This is done for easier usage in `Hamilton::Storage`.
struct Hamilton::Any
  # All possible JSON types.
  alias Type = Nil | Bool | Int64 | Float64 | String | Array(Hamilton::Any) | Hash(String, Hamilton::Any)

  # Returns the raw underlying value.
  private property raw : Type

  # Creates a `Hamilton::Any` that wraps the given value.
  def initialize(@raw : Type)
  end

  # :ditto:
  def self.new(raw : Int) : self
    new(raw.to_i64)
  end

  # :ditto:
  def self.new(raw : Float) : self
    new(raw.to_f64)
  end

  # :ditto:
  def self.new(raw : Array) : self
    array = [] of Hamilton::Any
    raw.each do |element|
      array << new element
    end
    new array
  end

  # :ditto:
  def self.new(raw : Hash) : self
    hash = {} of String => Hamilton::Any
    raw.each do |key, value|
      hash[key] = new value
    end
    new hash
  end

  # Reads a `Hamilton::Any` value from the given pull parser.
  def self.new(pull : JSON::PullParser) : self
    case pull.kind
    when .null?
      new pull.read_null
    when .bool?
      new pull.read_bool
    when .int?
      new pull.read_int
    when .float?
      new pull.read_float
    when .string?
      new pull.read_string
    when .begin_array?
      ary = [] of Hamilton::Any
      pull.read_array do
        ary << new(pull)
      end
      new ary
    when .begin_object?
      hash = {} of String => Hamilton::Any
      pull.read_object do |key|
        hash[key] = new(pull)
      end
      new hash
    else
      raise "Unknown pull kind: #{pull.kind}"
    end
  end

  # Assumes the underlying value is an `Array` or `Hash` and returns its size.
  # Raises if the underlying value is not an `Array` or `Hash`.
  def size : Int
    case object = @raw
    when Array, Hash
      object.size
    else
      raise "Expected Array or Hash for #size, not #{object.class}"
    end
  end

  # Assumes the underlying value is an `Array` and returns the element
  # at the given index.
  # Raises if the underlying value is not an `Array`.
  def [](index : Int) : Hamilton::Any
    case object = @raw
    when Array
      object[index]
    else
      raise "Expected Array for #[](index : Int), not #{object.class}"
    end
  end

  # Assumes the underlying value is an `Array` and returns the element
  # at the given index, or `nil` if out of bounds.
  # Raises if the underlying value is not an `Array`.
  def []?(index : Int) : Hamilton::Any?
    case object = @raw
    when Array
      object[index]?
    else
      raise "Expected Array for #[]?(index : Int), not #{object.class}"
    end
  end

  # Assumes the underlying value is a `Hash` and returns the element
  # with the given key.
  # Raises if the underlying value is not a `Hash`.
  def [](key : String) : Hamilton::Any
    case object = @raw
    when Hash
      object[key]
    else
      raise "Expected Hash for #[](key : String), not #{object.class}"
    end
  end

  # Assumes the underlying value is a `Hash` and returns the element
  # with the given key, or `nil` if the key is not present.
  # Raises if the underlying value is not a `Hash`.
  def []?(key : String) : Hamilton::Any?
    case object = @raw
    when Hash
      object[key]?
    else
      raise "Expected Hash for #[]?(key : String), not #{object.class}"
    end
  end

  # Traverses the depth of a structure and returns the value.
  # Returns `nil` if not found.
  def dig?(index_or_key : Int | String, *subkeys : Int | String) : Hamilton::Any?
    self[index_or_key]?.try &.dig?(*subkeys)
  end

  # :nodoc:
  def dig?(index_or_key : Int | String) : Hamilton::Any?
    case @raw
    when Hash, Array
      self[index_or_key]?
    else
      nil
    end
  end

  # Traverses the depth of a structure and returns the value, otherwise raises.
  def dig(index_or_key : Int | String, *subkeys : Int | String) : Hamilton::Any
    self[index_or_key].dig(*subkeys)
  end

  # :nodoc:
  def dig(index_or_key : Int | String) : Hamilton::Any
    self[index_or_key]
  end

  # Checks that the underlying value is `Nil`, and returns `nil`.
  # Raises otherwise.
  def as_nil : Nil
    @raw.as(Nil)
  end

  # Checks that the underlying value is `Bool`, and returns its value.
  # Raises otherwise.
  def as_bool : Bool
    @raw.as(Bool)
  end

  # Checks that the underlying value is `Bool`, and returns its value.
  # Returns `nil` otherwise.
  def as_bool? : Bool?
    as_bool if @raw.is_a?(Bool)
  end

  # Checks that the underlying value is `Int`, and returns its value as an `Int32`.
  # Raises otherwise.
  def as_i : Int32
    @raw.as(Int).to_i
  end

  # Checks that the underlying value is `Int`, and returns its value as an `Int32`.
  # Returns `nil` otherwise.
  def as_i? : Int32?
    as_i if @raw.is_a?(Int)
  end

  # Checks that the underlying value is `Int`, and returns its value as an `Int64`.
  # Raises otherwise.
  def as_i64 : Int64
    @raw.as(Int).to_i64
  end

  # Checks that the underlying value is `Int`, and returns its value as an `Int64`.
  # Returns `nil` otherwise.
  def as_i64? : Int64?
    as_i64 if @raw.is_a?(Int64)
  end

  # Checks that the underlying value is `Float` (or `Int`), and returns its value as an `Float64`.
  # Raises otherwise.
  def as_f : Float64
    case raw = @raw
    when Int
      raw.to_f
    else
      raw.as(Float64)
    end
  end

  # Checks that the underlying value is `Float` (or `Int`), and returns its value as an `Float64`.
  # Returns `nil` otherwise.
  def as_f? : Float64?
    case raw = @raw
    when Int
      raw.to_f
    else
      raw.as?(Float64)
    end
  end

  # Checks that the underlying value is `Float` (or `Int`), and returns its value as an `Float32`.
  # Raises otherwise.
  def as_f32 : Float32
    case raw = @raw
    when Int
      raw.to_f32
    else
      raw.as(Float).to_f32
    end
  end

  # Checks that the underlying value is `Float` (or `Int`), and returns its value as an `Float32`.
  # Returns `nil` otherwise.
  def as_f32? : Float32?
    case raw = @raw
    when Int
      raw.to_f32
    when Float
      raw.to_f32
    else
      nil
    end
  end

  # Checks that the underlying value is `String`, and returns its value.
  # Raises otherwise.
  def as_s : String
    @raw.as(String)
  end

  # Checks that the underlying value is `String`, and returns its value.
  # Returns `nil` otherwise.
  def as_s? : String?
    as_s if @raw.is_a?(String)
  end

  # Checks that the underlying value is `Array`, and returns its value.
  # Raises otherwise.
  def as_a : Array(Hamilton::Any)
    @raw.as(Array)
  end

  # Checks that the underlying value is `Array`, and returns its value.
  # Returns `nil` otherwise.
  def as_a? : Array(Hamilton::Any)?
    as_a if @raw.is_a?(Array)
  end

  # Checks that the underlying value is `Hash`, and returns its value.
  # Raises otherwise.
  def as_h : Hash(String, Hamilton::Any)
    @raw.as(Hash)
  end

  # Checks that the underlying value is `Hash`, and returns its value.
  # Returns `nil` otherwise.
  def as_h? : Hash(String, Hamilton::Any)?
    as_h if @raw.is_a?(Hash)
  end

  # :nodoc:
  def pretty_print(pp)
    @raw.pretty_print(pp)
  end

  # Returns `true` if both `self` and *other*'s raw object are equal.
  def ==(other : Hamilton::Any)
    raw == other.raw
  end

  # Returns `true` if the raw object is equal to *other*.
  def ==(other)
    raw == other
  end

  # See `Object#hash(hasher)`
  def_hash raw

  # :nodoc:
  def to_json(json : JSON::Builder) : Nil
    raw.to_json(json)
  end

  # :nodoc:
  def to_yaml(yaml : YAML::Nodes::Builder) : Nil
    raw.to_yaml(yaml)
  end

  # Returns a new Hamilton::Any instance with the `raw` value `dup`ed.
  def dup
    Hamilton::Any.new(raw.dup)
  end

  # Returns a new Hamilton::Any instance with the `raw` value `clone`ed.
  def clone : Hamilton::Any
    Hamilton::Any.new(raw.clone)
  end
end

class Object
  def ===(other : Hamilton::Any)
    self === other.raw
  end
end

struct Value
  def ==(other : Hamilton::Any)
    self == other.raw
  end
end

class Reference
  def ==(other : Hamilton::Any)
    self == other.raw
  end
end

class Array
  def ==(other : Hamilton::Any)
    self == other.raw
  end
end

class Hash
  def ==(other : Hamilton::Any)
    self == other.raw
  end
end

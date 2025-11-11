require "./any"

# Storage class for `Hamilton::Context`. Basically, it's a hidden `Hash(Symbol, Hamilton::Any)` with overridden
# `[]`, `[]?`, and `[]=` to not need to explicitly convert some type to `Hamilton::Any`.
class Hamilton::Storage
  private property raw : Hash(Symbol, Hamilton::Any)

  # Create an empty `Hamilton::Storage`.
  def initialize
    @raw = Hash(Symbol, Hamilton::Any).new
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

  # Assignes `value` to a `key`. Raises an `ArgumentError` if something goes wrong (wrong type of `value`).
  def []=(key : Symbol, value)
    begin
      @raw[key] = Hamilton::Any.new(value)
    rescue
      # I assume that no other errors could be found
      raise ArgumentError.new message: "Data in `Hamilton::Storage` should be convertible to type `Hamilton::Any` (*similar* to `JSON::Any`), but got #{typeof(value)}"
    end
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
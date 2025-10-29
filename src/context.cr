require "json"

# Context is a storage for some state.
#
# As it was developed primary for `Hamilton::CmdHandler`, `Hamilton::Context` maps a key of type  
# `Int64 | String | Symbol` to a named tuple with two fields:
#  - `method : Symbol | Nil` -- name of some method
#  - `data: Hash(Symbol, JSON::Any) | Nil)` -- storage for some specific data
class Hamilton::Context
  private property default_method : Symbol | Nil
  private property inner : Hash(Int64 | String | Symbol, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))

  # Initializer of the context storage.
  #
  # Optional parameters:
  # `default_method : Symbol | Nil` -- something that will be the default value for the `method` field
  # `inner : Hash(Int32 | String | Symbol, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))` -- storage itself
  def initialize(*,
      @inner = Hash(Int64 | String | Symbol, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil)).new,
      @default_method = nil
    )
  end

  # Setter for the pair `key, value`.
  def set(key : Int64 | String | Symbol, value : NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))
    @inner[key] = value
    return @inner[key]
  end

  # Setter that sets only method for the key.
  def set(key : Int64 | String | Symbol, method : Symbol)
    data = if inner = @inner[key]?
      inner[:data]
    else
      nil
    end
  
    @inner[key] = {method: method, data: data}
    return @inner[key]
  end

  # Setter that sets only data for the key.
  def set(key : Int64 | String | Symbol, data : Hash(Symbol, JSON::Any) | Nil)
    method = if inner = @inner[key]?
      inner[:method]
    else
      @default_method
    end
  
    @inner[key] = {method: method, data: data}
    return @inner[key]
  end

  # Reset the context for the `key`, i.e. the key will map to `{method: default_method, data: nil}` if present.
  def clean(key : Int64 | String | Symbol)
    if @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
      return @inner[key]
    end
    return nil
  end

  # Reset the data for the `key`.
  def clean_data(key : Int64 | String | Symbol)
    if inner = @inner[key]?
      @inner[key] = {method: inner[:method], data: nil}
      return @inner[key]
    end
    return nil
  end

  # Reset the method for the `key`.
  def clean_method(key : Int64 | String | Symbol)
    if inner = @inner[key]?
      @inner[key] = {method: @default_method, data: inner[:data]}
      return @inner[key]
    end
    return nil
  end

  # Delete the `key` from the storage.
  def delete(key : Int64 | String | Symbol)
    @inner.delete(key)
  end

  # Return the context for the `key`.
  #
  # NOTE: if there was not a context for the `key`, it will be iplicitly created with `{method: default_method, data: nil}`.
  def get(key : Int64 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key]
  end

  # Return the method for the `key`.
  #
  # NOTE: if there was not a context for the `key`, it will be iplicitly created with `{method: default_method, data: nil}`.
  def get_method(key : Int64 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key][:method]
  end

  # Return the data for the `key`.
  #
  # NOTE: if there was not a context for the `key`, it will be iplicitly created with `{method: default_method, data: nil}`.
  def get_data(key : Int64 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key][:data]
  end

  # Return the context for the `key`.
  def get?(key : Int64 | String | Symbol)
    return @inner[key]?
  end

  # Return the method for the `key`.
  def get_method?(key : Int64 | String | Symbol)
    if inner = @inner[key]?
      return inner[:method]
    end
    return nil
  end

  # Return the data for the `key`.
  def get_data?(key : Int64 | String | Symbol)
    if inner = @inner[key]?
      return inner[:data]
    end
    return nil
  end
end
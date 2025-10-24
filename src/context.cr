require "json"

class Hamilton::Context
  private property default_method : Symbol | Nil
  private property inner : Hash(Int32 | String | Symbol, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))

  def initialize(*,
      @inner = Hash(Int32 | String | Symbol, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil)).new,
      @default_method = nil
    )
  end

  def set(key : Int32 | String | Symbol, value : NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))
    @inner[key] = value
    return @inner[key]
  end

  def set(key : Int32 | String | Symbol, method : Symbol)
    data = if inner = @inner[key]?
      inner[:data]
    else
      nil
    end
  
    @inner[key] = {method: method, data: data}
    return @inner[key]
  end

  def set(key : Int32 | String | Symbol, data : Hash(Symbol, JSON::Any))
    method = if inner = @inner[key]?
      inner[:method]
    else
      nil
    end
  
    @inner[key] = {method: method, data: data}
    return @inner[key]
  end

  def clean(key : Int32 | String | Symbol)
    if @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
      return @inner[key]
    end
    return nil
  end

  def clean_data(key : Int32 | String | Symbol)
    if inner = @inner[key]?
      @inner[key] = {method: inner[:method], data: nil}
      return @inner[key]
    end
    return nil
  end

  def clean_method(key : Int32 | String | Symbol)
    if inner = @inner[key]?
      @inner[key] = {method: @default_method, data: inner[:data]}
      return @inner[key]
    end
    return nil
  end

  def delete(key : Int32 | String | Symbol)
    @inner.delete(key)
  end

  def get(key : Int32 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key]
  end

  def get_method(key : Int32 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key][:method]
  end

  def get_data(key : Int32 | String | Symbol)
    unless @inner.has_key?(key)
      @inner[key] = {method: @default_method, data: nil}
    end
    return @inner[key][:data]
  end

  def get?(key : Int32 | String | Symbol)
    return @inner[key]?
  end

  def get_method?(key : Int32 | String | Symbol)
    if inner = @inner[key]?
      return inner[:method]
    end
    return nil
  end

  def get_data?(key : Int32 | String | Symbol)
    if inner = @inner[key]?
      return inner[:data]
    end
    return nil
  end
end
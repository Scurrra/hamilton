require "json"

class ApiResult(T)
  include JSON::Serializable
  
  property ok : Bool

  property result : T

  def initialize(@ok, @result)
  end
end
require "json"

# Describes a story area pointing to a location. Currently, a story can have up to 10 location areas.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaTypeLocation
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the area, always “location”.
  property type : String

  # Location latitude in degrees.
  property latitude : Float32

  # Location longitude in degrees.
  property longitude : Float32

  # Address of the location.
  property address : Hamilton::Types::LocationAddress
end

# Describes a story area pointing to a suggested reaction. Currently, a story can have up to 5 suggested reaction areas.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaTypeSuggestedReaction
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the area, always "suggested_reaction".
  property type : String

  # Type of the reaction.
  property reaction_type : Hamilton::Types::ReactionType

  # Pass True if the reaction area has a dark background.
  property is_dark : Bool | Nil

  # Pass True if reaction area corner is flipped.
  property is_flipped : Bool | Nil
end

# Describes a story area pointing to an HTTP or tg:// link. Currently, a story can have up to 3 link areas.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaTypeLink
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the area, always "link".
  property type : String

  # HTTP or `tg://` URL to be opened when the area is clicked.
  property url : String
end

# Describes a story area containing weather information. Currently, a story can have up to 3 weather areas.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaTypeWeather
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the area, always "weather".
  property type : String

  # Temperature, in degree Celsius.
  property temperature : Float32

  # Emoji representing the weather.
  property emoji : String

  # A color of the area background in the ARGB format.
  property background_color : Int32
end

# Describes a story area pointing to a unique gift. Currently, a story can have at most 1 unique gift area.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaTypeUniqueGift
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the area, always "unique_gift".
  property type : String

  # Unique name of the gift.
  property name : String
end

# Describes the type of a clickable area on a story.
alias Hamilton::Types::StoryAreaType = Hamilton::Types::StoryAreaTypeLocation | Hamilton::Types::StoryAreaTypeSuggestedReaction | Hamilton::Types::StoryAreaTypeLink | Hamilton::Types::StoryAreaTypeWeather | Hamilton::Types::StoryAreaTypeUniqueGift
require "json"

# This object represents a venue.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Venue
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

  # Venue location. Can't be a live location.
  property location : Hamilton::Types::Location

  # Name of the venue.
  property title : String

  # Address of the venue.
  property address : String

  # Foursquare identifier of the venue.
  property foursquare_id : String | Nil

  # Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.).
  property foursquare_type : String | Nil

  # Google Places identifier of the venue.
  property google_place_id : String | Nil

  # Google Places type of the venue.
  property google_place_type : String | Nil
end
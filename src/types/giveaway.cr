require "json"

# This object represents a message about a scheduled giveaway.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Giveaway
  include JSON::Serializable

  def initialize(**params)
    {%begin%}

    {% properties = {} of Nil => Nil %}
    {% for ivar in @type.instance_vars %}
      {% unless ivar.id.stringify == "non_nil_fields" %}
      {%
        properties[ivar.id] = {
          key: ivar.id.stringify,
          type: ivar.type,
        }
      %}
      {% end %}
    {% end %}
    
    {% for name, value in properties %}
      %var{name} = uninitialized {{value[:type]}}
      %found{name} = false
    {% end %}
  
    params_keys, i = params.keys, 0
    while i < params_keys.size
      key = params_keys[i]
      case key.to_s
      {% for name, value in properties %}
      when {{value[:key]}}
        if params.has_key?({{value[:key]}})
          if param = params[{{value[:key]}}]?
            unless typeof(param) <= {{value[:type]}}
              raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, typeof(param))
            end

            %var{name} = param
            %found{name} = true
          else
            raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, Nil)
          end
        end
      {% end %}
      else
        raise Hamilton::Errors::UnknownField.new(key)
      end
      i += 1
    end

    {% for name, value in properties %}
      if %found{name}
        @{{name}} = %var{name}
      {% unless Nil < value[:type] %}
      else
        raise Hamilton::Errors::MissingField.new({{name.stringify}})
      {% end %}
      end
    {% end %}

    #{%debug%}
    {%end%}
    
    after_initialize
  end

  # List of available non-nil fields.
  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  # :nodoc:
  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end
  
  # The list of chats which the user must join to participate in the giveaway.
  property chats : Array(Hamilton::Types::Chat)

  # Point in time (Unix timestamp) when winners of the giveaway will be selected.
  property winners_selection_date : Int32

  # The number of users which are supposed to be selected as winners of the giveaway.
  property winner_count : Int32

  # True, if only users who join the chats after the giveaway started should be eligible to win.
  property only_new_members : Bool | Nil

  # True, if the list of giveaway winners will be visible to everyone.
  property has_public_winners : Bool | Nil

  # Description of additional giveaway prize.
  property prize_description : String | Nil

  # A list of two-letter ISO 3166-1 alpha-2 country codes indicating the countries from which eligible users for the giveaway must come. If empty, then all users can participate in the giveaway. Users with a phone number that was bought on Fragment can always participate in giveaways.
  property country_codes : Array(String) | Nil

  # The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only.
  property prize_star_count : Int32 | Nil

  # The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only.
  property premium_subscription_month_count : Int32 | Nil
end
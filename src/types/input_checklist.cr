require "json"

# Describes a checklist to create.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputChecklist
  include JSON::Serializable

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

  # Title of the checklist; 1-255 characters after entities parsing.
  property title : String

  # Mode for parsing entities in the title.
  property parse_mode : String

  # List of special entities that appear in the title, which can be specified instead of parse_mode. Currently, only bold, italic, underline, strikethrough, spoiler, and custom_emoji entities are allowed.
  property title_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # List of 1-30 tasks in the checklist.
  property tasks : Array(Hamilton::Types::InputChecklistTask)

  # Pass True if other users can add tasks to the checklist.
  property others_can_add_tasks : Bool | Nil

  # Pass True if other users can mark tasks as done or not done in the checklist.
  property others_can_mark_tasks_as_done : Bool | Nil
end
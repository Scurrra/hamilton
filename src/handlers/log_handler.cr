require "../handler"
require "log"

# Handler that logs each update.
class Hamilton::LogHandler
  include Hamilton::Handler

  # Logger instance.
  property log : Log

  def initialize(source : String = "Hamilton::Bot", level : Log::Severity = Log::Severity::Info)
    @log = Log.for(source, level)
  end

  def call(update : Hamilton::Types::Update)
    start = Time.monotonic
    status, error = :ok, nil

    begin
      call_next(update)
    rescue ex : Exception
      status = :bad
      error = ex
    ensure
      elapsed = Time.monotonic - start
      elapsed_text = elapsed_text(elapsed)

      update_types = update.non_nil_fields
      update_types.delete("update_id")
    
      if status == :ok
        @log.info { "#{update.update_id} - #{update_types[0]} (#{elapsed_text})" }
      else
        @log.error(exception: error) { "#{update.update_id} - #{update_types[0]} (#{elapsed_text})" }
      end
    end
  end

  private def elapsed_text(elapsed)
    minutes = elapsed.total_minutes
    return "#{minutes.round(2)}m" if minutes >= 1

    "#{elapsed.total_seconds.humanize(precision: 2, significant: false)}s"
  end
end
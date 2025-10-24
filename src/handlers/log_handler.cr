require "../handler"
require "log"

class Hamilton::LogHandler
  include Hamilton::Handler

  property log : Log

  def initialize(@log = Log.for("Hamilton::Bot"))
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
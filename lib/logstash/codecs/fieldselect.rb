# encoding: utf-8
require "logstash/codecs/base"
require "logstash/codecs/line"

class LogStash::Codecs::Fieldselect < LogStash::Codecs::Base

  # This codec will select only the fields listed or default
  # to only selecting message
  #
  # input {
  #   stdin { codec => fieldselect { fields => [] }
  # }
  # 
  # or
  # 
  # output {
  #   stdout { codec => fieldselect { fields => [] }
  # }
  config_name "fieldselect"
  
  # Select fields to output, concated with a comma
  config :fields, :validate => :array, :default => ['message']

  public
  def register
    @lines = LogStash::Codecs::Line.new
    @lines.charset = "UTF-8"
  end

  public
  def decode(data)
    @lines.decode(data) do |line|
      logger.debug? and @logger.debug("Running fieldselect codec", :data => data)
      selected = field_selector(line)
      logger.debug? and @logger.debug("Fieldselect codec ran", :selected => selected)
      yield LogStash::Event.new(selected)
    end
  end # def decode

  public
  def encode(event)
    encoded = field_concater(event)
    @on_event.call(event, encoded)
  end # def encode

  private
  def field_selector(data)
    selected = {}
    @fields.each do |field|
      selected[field] = data[field]
    end
    return selected
  end

  private
  def field_concater(data)
    concated = ""
    @fields.each do |field|
      if data[field] == nil 
        concated += ","
        next
      end
      concated += data[field].to_s + ", "
    end
    concated.chomp!(", ")
    return concated + "\n"
  end
end # class LogStash::Codecs::Fieldselect

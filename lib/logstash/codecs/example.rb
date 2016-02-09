# encoding: utf-8
require "logstash/codecs/base"
require "logstash/codecs/line"
require "logstash/namespace"

# Add any asciidoc formatted documentation here
class LogStash::Codecs::Example < LogStash::Codecs::Base

  # This example codec will append a string to the message field
  # of an event, either in the decoding or encoding methods
  #
  # This is only intended to be used as an example.
  #
  # input {
  #   stdin { codec => example }
  # }
  #
  # or
  #
  # output {
  #   stdout { codec => example }
  # }
  config_name "example"

  # Append a string to the message
  config :append, :validate => :string, :default => ', Hello World!'

  public
  def register
    @lines = LogStash::Codecs::Line.new
    @lines.charset = "UTF-8"
  end

  public
  def decode(data)
    @lines.decode(data) do |line|
      replace = { "message" => line["message"].to_s + @append }
      yield LogStash::Event.new(replace)
    end
  end # def decode

  public
  def encode(event)
    @on_event.call(event, event["message"].to_s + @append + NL)
  end # def encode

end # class LogStash::Codecs::Example

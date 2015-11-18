# encoding: utf-8

require "logstash/devutils/rspec/spec_helper"
require "logstash/codecs/fieldselect"
require "logstash/event"

describe LogStash::Codecs::Fieldselect do
  context "default settings" do
    subject do
      next LogStash::Codecs::Fieldselect.new
    end

    context "#encode" do
      let (:event) {LogStash::Event.new({"message" => "hello world", "host" => "test", "leggo" => "my eggo"})}

      it "should return only the default select field, message" do
        expect(subject).to receive(:on_event).once.and_call_original
        subject.on_event do |e, d|
          insist {d} == event['message'] + "\n"
        end
        subject.encode(event)
      end
    end

    context "#decode" do
      it "should return only the default select field, message" do
        decoded = false
        subject.decode("hello world\n") do |e|
          decoded = true
          insist { e.is_a?(LogStash::Event) }
          insist { e["message"] } == "hello world"
          insist { e["host"] } == nil
        end
        insist { decoded } == true
      end
  
    end
  end
 
  context "select specific fields" do
    subject do
      next LogStash::Codecs::Fieldselect.new({'fields' => ['message', 'leggo']})
    end
    
    context "#encode" do
      it "should return both selected fields, message and leggo" do
        expect(subject).to receive(:on_event).once.and_call_original
        subject.on_event do |e, d|
          insist {d} == event['message'] + ", " + event['leggo'] + "\n"
        end
      end
    end
  end
end


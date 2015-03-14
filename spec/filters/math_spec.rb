# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/math"

describe LogStash::Filters::Math do

  describe "Test add" do
    # The logstash config goes here.
    # At this time, only filters are supported.
    config <<-CONFIG
      filter {
        math {
            calculate => [
                [ "add", "add_1", "add_2", "add_target" ],
                [ "sub", "sub_1", "sub_2", "sub_target" ],
                [ "div", "div_1", "div_2", "div_target" ],
                [ "mpx", "mpx_1", "mpx_2", "mpx_target" ]
            ]
        }
       }
    CONFIG

    sample( "add_1" => 2, "add_2" => 5 ) do
      insist { subject["add_target"] } == 7
    end
  end
end

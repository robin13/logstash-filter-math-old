# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/math"

describe LogStash::Filters::Math do
   
  describe "Additions" do
    # The logstash config.
    config <<-CONFIG
      filter {  math { calculate => [ [ "add", "var1", "var2", "result" ] ] } }
    CONFIG
  
    describe "should add two integers" do
      sample( "var1" => -2,  "var2" => 7 ) do
        expect( subject["result"] ).to eq( 5 )
      end
    end
    
    describe "should add two floats" do
      sample( "var1" => -2.4,  "var2" => 7.8 ) do
        expect( subject["result"] ).to eq( 5.4  )
      end
    end
    
    describe "two huge numbers should add to infinity" do
      sample( "var1" => 1.79769313486232e+308,  "var2" => 1e+308 ) do
        expect( subject["result"] ).to eq( Float::INFINITY )
      end
    end

    describe "one value being 0 should work" do
      sample( "var1" => 0,  "var2" => 7.8 ) do
        expect( subject["result"] ).to eq( 7.8 )
      end
    end
    describe "first value missing should result in nil" do
      sample( "var2" => 3 ) do
        expect( subject["result"] ).to be_nil
      end
    end
  
    describe "Second value missing should result in nil" do
      sample( "var1" => 3 ) do
        expect( subject["result"] ).to be_nil
      end
    end
  end

  describe "Subtractions" do
    # The logstash config.
    config <<-CONFIG
      filter {  math { calculate => [ [ "sub", "var1", "var2", "result" ] ] } }
    CONFIG
  
    describe "should subtract two integers" do
      sample( "var1" => -2,  "var2" => 7 ) do
        expect( subject["result"] ).to eq( -9 )
      end
    end
    
    describe "should subtract two floats" do
      sample( "var1" => -2.4,  "var2" => 7.8 ) do
        expect( subject["result"] ).to eq( -10.2  )
      end
    end
    
    describe "two huge negative numbers should subtract to negative infinity" do
      sample( "var1" => -1.79769313486232e+308,  "var2" => -1e+308 ) do
        expect( subject["result"] ).to eq( -Float::INFINITY )
      end
    end

    describe "first value missing should result in nil" do
      sample( "var2" => 3 ) do
        expect( subject["result"] ).to be_nil
      end
    end
    
    describe "Second value missing should result in nil" do
      sample( "var1" => 3 ) do
        expect( subject["result"] ).to be_nil
      end
    end
  end
end

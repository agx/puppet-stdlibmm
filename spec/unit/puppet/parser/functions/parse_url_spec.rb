#! /usr/bin/env ruby -S rspec
#
require 'spec_helper'

describe 'the parse_url function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("parse_url").should == "function_parse_url"
  end

  it 'should parse protocoll, host and path' do
    result = scope.function_parse_url(['http://example.com/foo'])
    result.should eq({"port"   => 80,
                      "path"   => "/foo",
                      "scheme" => "http",
                      "host"   => "example.com"})
  end


  it "should raise a ParseError if there is less than 1 arguments" do
    lambda { scope.function_parse_url([]) }.should( raise_error(Puppet::ParseError))
  end

  it "should raise a ParseError if there is more than 1 arguments" do
    lambda { scope.function_parse_url(['one', 'two']) }.should( raise_error(Puppet::ParseError))
  end

  it "should raise a ParseError if the URL format is invalid" do
    lambda { scope.function_parse_url(['not_a_url://foo://'])}.should( raise_error(Puppet::ParseError))
  end
end


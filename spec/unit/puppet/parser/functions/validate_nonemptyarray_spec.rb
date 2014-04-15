#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Parser::Functions.function(:validate_nonemptyarray) do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }
  describe 'when calling validate_nonemptyarray from puppet' do

    %w{ true false }.each do |the_string|
      it "should not compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptyarray('#{the_string}')"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Array/)
      end

      it "should not compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptyarray(#{the_string})"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Array/)
      end
    end

    it "should compile when multiple array arguments are passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = [ 'foo', 'bar' ]
        $bar = [ 'one', 'two' ]
        validate_nonemptyarray($foo, $bar)
      ENDofPUPPETcode
      scope.compiler.compile
    end

    it "should not compile when an undef variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = undef
        validate_nonemptyarray($foo)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Array/)
    end

    it "should not compile when with an empty array" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = []
        validate_nonemptyarray($foo)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is an empty Array/)
    end

    it "should not compile when multiple arrays are padded and one is empty" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = [ 'not', 'empty' ]
        $bar = []
        validate_nonemptyarray($foo, $bar)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is an empty Array/)
    end
  end
end

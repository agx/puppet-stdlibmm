#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Parser::Functions.function(:validate_nonemptyhash) do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }
  describe 'when calling validate_nonemptyhash from puppet' do

    %w{ true false }.each do |the_string|
      it "should not compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptyhash('#{the_string}')"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Hash/)
      end

      it "should not compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptyhash(#{the_string})"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Hash/)
      end
    end

    it "should compile when multiple hash arguments are passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = { 'foo' => 'bar' }
        $bar = { 'one' => 'two' }
        validate_nonemptyhash($foo, $bar)
      ENDofPUPPETcode
      scope.compiler.compile
    end

    it "should not compile when an undef variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = undef
        validate_nonemptyhash($foo)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not an Hash/)
    end

    it "should not compile when with an empty hash" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = {}
        validate_nonemptyhash($foo)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is an empty Hash/)
    end

    it "should not compile when multiple hashes are padded and one is empty" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = { 'foo' => 'bar' }
        $bar = {}
        validate_nonemptyhash($foo, $bar)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is an empty Hash/)
    end
  end
end

#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Parser::Functions.function(:validate_nonemptystring) do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  describe 'when calling validate_nonemptystring from puppet' do

    %w{ foo bar baz }.each do |the_string|

      it "should compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptystring('#{the_string}')"
        scope.compiler.compile
      end

      it "should compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptystring(#{the_string})"
        scope.compiler.compile
      end

    end

    %w{ true false }.each do |the_string|
      it "should compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptystring('#{the_string}')"
        scope.compiler.compile
      end

      it "should not compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptystring(#{the_string})"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is not a string/)
      end
    end

    it "should compile when multiple string arguments are passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = 'one'
        $bar = 'two'
        validate_nonemptystring($foo, $bar)
      ENDofPUPPETcode
      scope.compiler.compile
    end

    it "should not compile when an explicitly undef variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = undef
        validate_nonemptystring($foo)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is empty or undef/)
    end

    it "should not compile when an undefined variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        validate_nonemptystring($foobarbazishouldnotexist)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is empty or undef/)
    end

    it "should not compile when one string is empty" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = 'one'
        $bar = ''
        $baz = 'three'
        validate_nonemptystring($foo, $bar)
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /is empty or undef/)
    end

  end
end

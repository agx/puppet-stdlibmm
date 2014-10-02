#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Parser::Functions.function(:validate_nonemptyarray_msg) do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }
  describe 'when calling validate_nonemptyarray_msg from puppet' do

    %w{ true false }.each do |the_string|
      it "should not compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptyarray_msg('#{the_string}', 'a msg')"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /a msg/)
      end

      it "should not compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptyarray_msg(#{the_string}, 'a msg')"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /a msg/)
      end
    end

    it "should compile when a array argument is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = [ 'foo', 'bar' ]
        validate_nonemptyarray_msg($foo, 'a msg')
      ENDofPUPPETcode
      scope.compiler.compile
    end

    it "should not compile when an undef variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = undef
        validate_nonemptyarray_msg($foo, 'a msg')
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /a msg/)
    end

    it "should not compile when with an empty array" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = []
        validate_nonemptyarray_msg($foo, 'a msg')
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /a msg/)
    end
  end
end

#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Parser::Functions.function(:validate_nonemptystring_msg) do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  describe 'when calling validate_nonemptystring_msg from puppet' do

    it "should compile when foo is a string" do
      Puppet[:code] = "validate_nonemptystring_msg('foo', 'a msg')"
      scope.compiler.compile
    end


    %w{ true false }.each do |the_string|
      it "should compile when #{the_string} is a string" do
        Puppet[:code] = "validate_nonemptystring_msg('#{the_string}', 'a msg')"
        scope.compiler.compile
      end

      it "should not compile when #{the_string} is a bare word" do
        Puppet[:code] = "validate_nonemptystring_msg(#{the_string}, 'a msg')"
        expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /msg/)
      end
    end

    it "should not compile when an explicitly undef variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $foo = undef
        validate_nonemptystring_msg($foo, 'a msg')
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /msg/)
    end

    it "should not compile when an undefined variable is passed" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        validate_nonemptystring_msg($foobarbazishouldnotexist, 'a msg')
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /msg/)
    end

    it "should not compile when the string is empty" do
      Puppet[:code] = <<-'ENDofPUPPETcode'
        $bar = ''
        validate_nonemptystring_msg($bar, 'a msg')
      ENDofPUPPETcode
      expect { scope.compiler.compile }.to raise_error(Puppet::ParseError, /msg/)
    end

  end
end

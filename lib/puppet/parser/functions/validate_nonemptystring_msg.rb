module Puppet::Parser::Functions

  newfunction(:validate_nonemptystring_msg, :doc => <<-'ENDHEREDOC') do |args|
    Validate that the passed value is string data and not empty
    i.e. not undef or ''. Abort catalog compilation if it fails this
    check and print the message given as second argment.

    The following values will pass:

        $my_string = "one two"
        validate_nonemptystring_msg($my_string, 'Not a string')

    The following values will fail, causing compilation to abort and print
    'Not a string':

        validate_nonemptystring_msg(true. 'Not a string')
        validate_nonemptystring_msg([ 'some', 'array' ], 'Not a string')

    ENDHEREDOC

    unless args.length == 2 then
      raise Puppet::ParseError, ("validate_nonemptystring_msg(): wrong number of arguments (#{args.length}; must be 2)")
    end

    str = args[0]
    msg = args[1]
    unless str.is_a?(String) and str != nil and str != '' and str != :undef
      raise Puppet::ParseError, (msg)
    end
  end
end

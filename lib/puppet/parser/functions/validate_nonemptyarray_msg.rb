module Puppet::Parser::Functions

  newfunction(:validate_nonemptyarray_msg, :doc => <<-'ENDHEREDOC') do |args|
    Validate that the passed value is an array data structure. Abort catalog
    compilation if any value fails this check. Also abort if any of the arrays
    is empty. On failure it prints the message given as the second argument.

    The following values will pass:

        $my_array = [ 'one', 'two' ]
        validate_nonemptyarray_msg($my_array, 'foo')

    The following values will fail, causing compilation to abort with the given msg:

        validate_nonemptyarray_msg(true, 'Not a nonempty array')
        validate_nonemptyarray_msg([], 'Not a nonempty array')

    ENDHEREDOC

    unless args.length == 2 then
      raise Puppet::ParseError, ("validate_nonemptyarray(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    arg = args[0]
    msg = args[1]
    unless arg.is_a?(Array) and arg.length > 0
      raise Puppet::ParseError, (msg)
    end
  end
end

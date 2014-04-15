module Puppet::Parser::Functions

  newfunction(:validate_nonemptyarray, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are array data structures. Abort catalog
    compilation if any value fails this check. Also abort if any of the arrays
    is empty.

    The following values will pass:

        $my_array = [ 'one', 'two' ]
        validate_nonemptyarray($my_array)

    The following values will fail, causing compilation to abort:

        validate_nonemptyarray(true)
        validate_nonemptyarray([])
        validate_nonemptyarray('some_string')
        $undefined = undef
        validate_nonemptyarray($undefined)

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_nonemptyarray(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    args.each do |arg|
      unless arg.is_a?(Array)
        raise Puppet::ParseError, ("#{arg.inspect} is not an Array.  It looks to be a #{arg.class}")
      end
      unless arg.length > 0
        raise Puppet::ParseError, ("#{arg.inspect} is an empty Array.")
      end
    end
  end
end

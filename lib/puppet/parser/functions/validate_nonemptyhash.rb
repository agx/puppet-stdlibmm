module Puppet::Parser::Functions

  newfunction(:validate_nonemptyhash, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are hash data structures. Abort catalog
    compilation if any value fails this check. Also abort if any of the hashes
    is empty.

    The following values will pass:

        $my_hash = { 'one' => 'two' }
        validate_nonemptyhash($my_array)

    The following values will fail, causing compilation to abort:

        validate_nonemptyhash(true)
        validate_nonemptyhash([])
        validate_nonemptyhash('some_string')
        $undefined = undef
        validate_nonemptyhash($undefined)

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_nonemptyhash(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    args.each do |arg|
      unless arg.is_a?(Hash)
        raise Puppet::ParseError, ("#{arg.inspect} is not an Hash.  It looks to be a #{arg.class}")
      end
      unless arg.keys.length > 0
        raise Puppet::ParseError, ("#{arg.inspect} is an empty Hash.")
      end
    end
  end
end

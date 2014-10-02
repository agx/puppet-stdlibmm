module Puppet::Parser::Functions

  newfunction(:validate_nonemptyhash_msg, :doc => <<-'ENDHEREDOC') do |args|
    Validate that the passed value is an hash data structure. Abort catalog
    compilation if any value fails this check. Also abort if any of the hashs
    is empty. On failure it prints the message given as the second argument.

    The following values will pass:

        $my_hash = { 'one', 'two' }
        validate_nonemptyhash_msg($my_hash, 'foo')

    The following values will fail, causing compilation to abort with the given msg:

        validate_nonemptyhash_msg(true, 'Not a nonempty hash')
        validate_nonemptyhash_msg([], 'Not a nonempty hash')

    ENDHEREDOC

    unless args.length == 2 then
      raise Puppet::ParseError, ("validate_nonemptyhash_msg(): wrong number of arguments (#{args.length}; must be == 2)")
    end

    arg = args[0]
    msg = args[1]
    unless arg.is_a?(Hash) and arg.keys.length > 0
      raise Puppet::ParseError, (msg)
    end
  end
end

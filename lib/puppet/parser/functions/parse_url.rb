require "uri"

module Puppet::Parser::Functions

    newfunction(:parse_url, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
      Parse an URL into its parts returning a hash.

        parse_url('http://example.com/foo')

      would result in

        {'host' => 'example.com', 'path' => '/foo', 'port': 8080, 'scheme': 'http' }
      ENDHEREDOC

    parts = {}
    if args.length != 1
      raise Puppet::ParseError, ("parse_url(): wrong number of arguments (#{args.length}: must be 1")
    end

    begin
      uri = URI::parse(args[0])
    rescue Exception => e
      raise Puppet::ParseError, e
    end
    parts['host'] = uri.host
    parts['path'] = uri.path
    parts['port'] = uri.port
    parts['scheme'] = uri.scheme
    parts
  end
end

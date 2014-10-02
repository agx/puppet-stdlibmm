# Standard Library-- #

[![Build Status](https://travis-ci.org/agx/puppet-stdlibmm.png?branch=master)](https://travis-ci.org/agx/puppet-stdlibmm)

This puppet module provides some function on top of the standard library. It's
called "stdlib minus minus".

# Functions #

parse_url
---------
Parse an URL into its parts returning a hash.

    parse_url('http://example.com:8080/foo')

would result in

    {'host' => 'example.com', 'path' => '/foo', 'port': 8080, 'scheme': 'http' }

validate_nonemptystring
-----------------------
Validate that all passed values are strings with a length greater 0
and not undef. Abort catalog compilation if any value fails this
check.

The following values will pass:

    $my_string = "one two"
    validate_nonemptystring($my_string, 'three')

The following values will fail, causing compilation to abort:

    validate_nonemptystring(true)
    validate_nonemptystring([ 'some', 'array' ])
    $undefined = undef
    validate_nonemptystring($undefined)

validate_nonemptystring_msg
---------------------------
Validate that the passed value is string data and not empty i.e. not
undef or ''. Abort catalog compilation if it fails this check and
print the message given as second argment.

The following values will pass:

    $my_string = "one two"
    validate_nonemptystring_msg($my_string, 'Not a string')

The following values will fail, causing compilation to abort and print
'Not a string':

    validate_nonemptystring_msg(true. 'Not a string')
    validate_nonemptystring_msg([ 'some', 'array' ], 'Not a string')

validate_nonemptyarray
----------------------
Validate that all passed values are array data structures. Abort
catalog compilation if any value fails this check. Also abort if any
of the arrays is empty.

The following values will pass:

    $my_array = [ 'one', 'two' ]
    validate_nonemptyarray($my_array)

The following values will fail, causing compilation to abort:

    validate_nonemptyarray(true)
    validate_nonemptyarray([])
    validate_nonemptyarray('some_string')
    $undefined = undef
    validate_nonemptyarray($undefined)

validate_nonemptyarray_msg
--------------------------
Validate that the passed value is an array data structure. Abort catalog
compilation if any value fails this check. Also abort if any of the arrays
is empty. On failure it prints the message given as the second argument.

The following values will pass:

    $my_array = [ 'one', 'two' ]
    validate_nonemptyarray_msg($my_array, 'foo')

The following values will fail, causing compilation to abort with the given msg:

    validate_nonemptyarray_msg(true, 'Not a nonempty array')
    validate_nonemptyarray_msg([], 'Not a nonempty array')

validate_nonemptyhash
---------------------
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

validate_nonemptyhash_msg
-------------------------
Validate that the passed value is an hash data structure. Abort catalog
compilation if any value fails this check. Also abort if any of the hashs
is empty. On failure it prints the message given as the second argument.

The following values will pass:

    $my_hash = { 'one', 'two' }
    validate_nonemptyhash_msg($my_hash, 'foo')

The following values will fail, causing compilation to abort with the given msg:

    validate_nonemptyhash_msg(true, 'Not a nonempty hash')
    validate_nonemptyhash_msg([], 'Not a nonempty hash')

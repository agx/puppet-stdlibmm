# Standard Library-- #

[![Build Status](https://travis-ci.org/agx/puppet-stdlibmm.png?branch=master)](https://travis-ci.org/agx/puppet-stdlibmm)

This puppet module provides some function on top of the standard library. It's
called "stdlib minus minus".

# Functions #

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

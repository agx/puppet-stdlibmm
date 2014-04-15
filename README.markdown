# Standard Library-- #

This puppet module provides some (in fact currently only one) function on top
of the standard library. It's called "stdlib minus minus".

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


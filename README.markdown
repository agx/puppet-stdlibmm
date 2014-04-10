# Standard Library-- #

This puppet module provides some (in fact currently only one) function on top
of the standard library. It's called "stdlib minus minus".

# Functions #

validate_nonemptystring
-----------------------
Validate that all passed values are strings with a length greater 0 and not undef. Abort catalog
compilation if any value fails this check.

The following values will pass:

    $my_string = "one two"
    validate_nonemptystring($my_string, 'three')

The following values will fail, causing compilation to abort:

    validate_nonemptystring(true)
    validate_nonemptystring([ 'some', 'array' ])
    $undefined = undef
    validate_nonemptystring($undefined)


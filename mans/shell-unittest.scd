shell-unittest(3)

# NAME
runUnitTests, appendTests, registerTests, setUp, setUpTests, tearDown,
tearDownTests, shouldSkip, assertTrue, assertFalse, assertEquals,
assertNotEquals, assertSame, assertNotSame, assertNull, assertNotNull,
messageTest, showSummary - a small unit-test framework for POSIX shells.

# SYNOPSIS
- runUnitTests
- appendTests *func* ...
- registerTests [*file*]
- setUp
- setUpTests
- tearDown
- tearDownTests
- shouldSkip
- assertTrue [*comment*] *condition|integer*
- assertFalse [*comment*] *condition|integer*
- assertEquals [*comment*] *expected* *actual*
- assertNotEquals [*comment*] *expected* *actual*
- assertSame [*comment*] *expected* *actual*
- assertNotSame [*comment*] *expected* *actual*
- assertNull [*comment*] *value*
- assertNotNull [*comment*] *value*
- messageTest *name* *message* *status*
- showSummary

# DESCRIPTION

A lightweight xUnit-style framework. You define test functions, register
them with *appendTests* or *registerTests*, and invoke *runUnitTests*.
Each test is expected to return a status of 0 (passed), 1 (failed) or 2
(skipped); any other value is treated as a fatal error and stops the
run.

## runUnitTests
Runs every registered test function, in sorted order, wrapping each one
with *setUp* and *tearDown* and the whole run with *setUpTests* and
*tearDownTests*. After each test it reports a status line (via
*messageTest*) and, at the end, a summary (via *showSummary*). An
optional `TESTCASES` filter restricts the run to the named tests.

It returns 0 when no test failed and 1 otherwise.

Example: a complete test file:
```
my_test()
{
    assertEquals 'hello' 'hello'
}
another_test()
{
    assertTrue '[ 1 -lt 2 ]'
    shouldSkip
}
registerTests "$0"
runUnitTests
```
run as:
```
$ sh my-unittests
[done] (another_test)
[done] (my_test)

tests passed:      0   0%
tests failed:      0   0%
tests skipped:     0   0%
tests total:       2
```

## appendTests
Registers one or more test functions to be run. Each name must already
be defined.

## registerTests
Scans *file* (default `"$0"`) and registers every function whose
defining line carries a literal comment marker of the form *# UnitTest*
(the `#` followed by the uppercase word *UnitTest*), e.g.:
```
my_testcase_function() { # UnitTest
    blah blah blah ...
}
```
A `# UnitTest` marker placed on a different line is not detected.

## setUp
Called before each individual test. It defaults to doing nothing and is
meant to be overridden by the caller.

## tearDown
Called after each individual test. It defaults to doing nothing and is
meant to be overridden by the caller.

## setUpTests
Called once before the first test. It defaults to doing nothing.

## tearDownTests
Called once after the last test. It defaults to doing nothing.

## shouldSkip
When called from inside a test function, causes that test to be marked
as skipped. Implemented as `exit 2`.

# ASSERTIONS
The assertion functions are meant to be called inside a test function.
Each takes an optional leading *comment*, which is printed on the line
above the failure reason. On success it returns 0; on failure it
terminates the test with status 1.

## assertTrue
Succeeds when *condition* (evaluated) is true, or when it is an integer
not equal to zero.

## assertFalse
Succeeds when *condition* is false, or when it is an integer equal to
zero.

## assertEquals
Succeeds when *expected* and *actual* compare as equal strings. Takes
an optional leading *comment*.

## assertSame
Alias of *assertEquals*; succeeds when *expected* and *actual* compare
as equal strings.

## assertNotEquals
Succeeds when *expected* and *actual* differ. Takes an optional leading
*comment*.

## assertNotSame
Alias of *assertNotEquals*; succeeds when *expected* and *actual*
differ.

## assertNull
Succeeds when *value* is the empty string.

## assertNotNull
Succeeds when *value* is not the empty string.

Example:
```
check_1_to_2()
{
    assertTrue '2 <= 3' 'second argument is at most 3'
    assertEquals 1 1
    assertNotNull 'x' 'non-null'
}
appendTests check_1_to_2
runUnitTests
```

# REPORTING

## messageTest
Prints a status line for a single test: the status is *name*, the test's
captured output is *message*, and the test's return code is *status*.
Status 0 maps to the *done* marker (green), 1 to *FAIL* (red) and 2 to
*skip* (yellow); anything else is printed in brackets. Controlled by
the *unittest_use_color* and *unittest_hide_successful* settings.

## showSummary
Prints the overall pass/fail/skip counts as a small table. Called
automatically by *runUnitTests* but may also be invoked on its own.

# ENVIRONMENT
The following *shell variables* (not exported environment variables)
change the module's behaviour:
- `TESTCASES` : run only the listed test names (space separated).
- `unittest_use_color` : when non-empty, colourise the status line.
- `unittest_show_condition` : on failure, also print the failing
  condition or comparison.
- `unittest_hide_successful` : suppress the `[done]` line for tests
  that passed.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.

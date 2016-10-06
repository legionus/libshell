% SHELL-UNITTEST
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

appendTests, assertEquals, assertFalse, assertNotEquals, assertNotNull, assertNotSame,
assertNull, assertSame, assertTrue, messageTest, registerTests, runUnitTests, setUp,
setUpTests, shouldSkip, showSummary, tearDown, tearDownTests

# SYNOPSIS #

- appendTests funcion_name
- registerTests [/tests-file]
- assertEquals [comment] expected actual
- assertFalse [comment] condition
- assertFalse [comment] integer
- assertNotEquals [comment] expected actual
- assertNotNull [comment] value
- assertNotSame [comment] expected actual
- assertNull [comment] value
- assertSame [comment] expected actual
- assertTrue [comment] condition
- assertTrue [comment] integer
- messageTest test-case test-message test-return-code
- runUnitTests 
- setUp
- setUpTests
- shouldSkip
- showSummary
- tearDown
- tearDownTests

# DESCRIPTION #
Unit testing framework for shell. The module was supposed to be compatible with [xUnit](https://en.wikipedia.org/wiki/XUnit).

## appendTests ##
Function registers new testing function.

## registerTests ##
Function automatically registeres test functions with 'UnitTest' comment.
The name of current shell script will be used if argument is not present.

Example:
```bash
my_testcase_function() # UnitTest
{
	blah blah blah ...
}
```

## assertEquals ##
Asserts that two arguments are equal to one another.
(called in testing function)

## assertFalse ##
Asserts that a given shell test condition (or integer) is false.
(called in testing function)

## assertNotEquals ##
Asserts that two arguments are not equal to one another.
(called in testing function)

## assertNotNull ##
Asserts that argument is not empty string.
(called in testing function)

## assertNotSame ##
Asserts that two arguments are not same.
(called in testing function)

## assertNull ##
Asserts that argument is a zero-length string.
(called in testing function)

## assertSame ##
Asserts that two arguments are same.
(called in testing function)

## assertTrue ##
Asserts that a given shell test condition (or integer) is true.
(called in testing function)

## shouldSkip ##
Skip test (called in testing function)

## messageTest ##
Function displays status message after each test.

## setUp ##
Function would be called before each test is run.

## setUpTests ##
Function would be called before all test is run.

## showSummary ##
Function displays summary statistic: how many tests passed and how many failed.

## tearDown ##
Function would be called after each test is run.

## tearDownTests ##
Function would be called after all test is run.

## runUnitTests ##
Function calls tests one by one and calls the function described above.

# ENVIRONMENT #

**TESTCASES** - Only perform listed tests.

**unittest_use_color** - Use color messages to show status.

**unittest_show_condition** - Append tests condition to comment message if test failed.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.


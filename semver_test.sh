#!/bin/sh

# NOTE: test_util is not included in this repo
. ./test_util/test_util.sh.inc

. ../installer/semver.sh

testSemverIsValid() {
	test_expect      semver_is_valid "0.0.0"
	test_expect      semver_is_valid "1.2.3"
	test_expect      semver_is_valid "100.200.300"
	test_expectFalse semver_is_valid "00.0.0"
	test_expectFalse semver_is_valid "0.00.0"
	test_expectFalse semver_is_valid "0.0.00"
	test_expectFalse semver_is_valid ".."
	test_expectFalse semver_is_valid ".2.3"
	test_expectFalse semver_is_valid "1..3"
	test_expectFalse semver_is_valid "1.2."
	test_expectFalse semver_is_valid "a.b.c"
	test_expectFalse semver_is_valid "1.2.c"
	test_expectFalse semver_is_valid "1.2"
	test_expectFalse semver_is_valid "1"
}

testSemverMajor() {
	test_expect [ "$(semver_major "0.2.3")"  = 0 ]
	test_expect [ "$(semver_major "1.2.3")"  = 1 ]
	test_expect [ "$(semver_major "10.2.3")" = 10 ]
}

testSemverMinor() {
	test_expect [ "$(semver_minor "1.0.3")"  = 0 ]
	test_expect [ "$(semver_minor "1.2.3")"  = 2 ]
	test_expect [ "$(semver_minor "1.20.3")" = 20 ]
}

testSemverPatch() {
	test_expect [ "$(semver_patch "1.2.0")"  = 0 ]
	test_expect [ "$(semver_patch "1.2.3")"  = 3 ]
	test_expect [ "$(semver_patch "1.2.30")" = 30 ]
}

testSemverEQ() {
	test_expect         semver_eq   "1.2.3"     "1.2.3"
	test_expect         semver_eq   "10.20.30"  "10.20.30"
	test_expect         semver_eq   "1.0.30"     "1.0.30"
}

testSemverGT() {
	test_expectFalse    semver_gt   "1.2.3"     "1.2.3"
	test_expectFalse    semver_gt   "10.20.30"  "10.20.30"
	test_expectFalse    semver_gt   "1.0.30"    "1.0.30"

	test_expect         semver_gt   "10.2.3"    "1.2.3"
	test_expect         semver_gt   "10.0.0"    "1.2.3"
	test_expect         semver_gt   "1.3.3"     "1.2.3"
	test_expect         semver_gt   "1.1.3"     "1.0.3"
	test_expect         semver_gt   "1.2.4"     "1.2.3"
	test_expect         semver_gt   "1.2.10"    "1.2.3"
	test_expect         semver_gt   "1.2.3"     "1.0.0"
	test_expect         semver_gt   "3.2.1"     "1.2.3"

	test_expectFalse    semver_gt   "1.2.3"     "10.2.3"
	test_expectFalse    semver_gt   "1.2.3"     "10.0.0"
	test_expectFalse    semver_gt   "1.2.3"     "1.3.3"
	test_expectFalse    semver_gt   "1.0.3"     "1.1.3"
	test_expectFalse    semver_gt   "1.2.3"     "1.2.4"
	test_expectFalse    semver_gt   "1.2.3"     "1.2.10"
	test_expectFalse    semver_gt   "1.0.0"     "1.2.3"
	test_expectFalse    semver_gt   "1.2.3"     "3.2.1"
}

testSemverGE() {
	test_expect         semver_ge   "1.2.3"     "1.2.3"
	test_expect         semver_ge   "10.20.30"  "10.20.30"
	test_expect         semver_ge   "1.0.30"    "1.0.30"

	test_expect         semver_ge   "10.2.3"    "1.2.3"
	test_expect         semver_ge   "10.0.0"    "1.2.3"
	test_expect         semver_ge   "1.3.3"     "1.2.3"
	test_expect         semver_ge   "1.1.3"     "1.0.3"
	test_expect         semver_ge   "1.2.4"     "1.2.3"
	test_expect         semver_ge   "1.2.10"    "1.2.3"
	test_expect         semver_ge   "1.2.3"     "1.0.0"
	test_expect         semver_ge   "3.2.1"     "1.2.3"

	test_expectFalse    semver_ge   "1.2.3"     "10.2.3"
	test_expectFalse    semver_ge   "1.2.3"     "10.0.0"
	test_expectFalse    semver_ge   "1.2.3"     "1.3.3"
	test_expectFalse    semver_ge   "1.0.3"     "1.1.3"
	test_expectFalse    semver_ge   "1.2.3"     "1.2.4"
	test_expectFalse    semver_ge   "1.2.3"     "1.2.10"
	test_expectFalse    semver_ge   "1.0.0"     "1.2.3"
	test_expectFalse    semver_ge   "1.2.3"     "3.2.1"
}

testSemverGE() {
	test_expect         semver_ge   "1.2.3"     "1.2.3"
	test_expect         semver_ge   "10.20.30"  "10.20.30"
	test_expect         semver_ge   "1.0.30"    "1.0.30"

	test_expect         semver_ge   "10.2.3"    "1.2.3"
	test_expect         semver_ge   "10.0.0"    "1.2.3"
	test_expect         semver_ge   "1.3.3"     "1.2.3"
	test_expect         semver_ge   "1.1.3"     "1.0.3"
	test_expect         semver_ge   "1.2.4"     "1.2.3"
	test_expect         semver_ge   "1.2.10"    "1.2.3"
	test_expect         semver_ge   "1.2.3"     "1.0.0"
	test_expect         semver_ge   "3.2.1"     "1.2.3"

	test_expectFalse    semver_ge   "1.2.3"     "10.2.3"
	test_expectFalse    semver_ge   "1.2.3"     "10.0.0"
	test_expectFalse    semver_ge   "1.2.3"     "1.3.3"
	test_expectFalse    semver_ge   "1.0.3"     "1.1.3"
	test_expectFalse    semver_ge   "1.2.3"     "1.2.4"
	test_expectFalse    semver_ge   "1.2.3"     "1.2.10"
	test_expectFalse    semver_ge   "1.0.0"     "1.2.3"
	test_expectFalse    semver_ge   "1.2.3"     "3.2.1"
}

testSemverLT() {
	test_expectFalse    semver_lt   "1.2.3"     "1.2.3"
	test_expectFalse    semver_lt   "10.20.30"  "10.20.30"
	test_expectFalse    semver_lt   "1.0.30"    "1.0.30"

	test_expectFalse    semver_lt   "10.2.3"    "1.2.3"
	test_expectFalse    semver_lt   "10.0.0"    "1.2.3"
	test_expectFalse    semver_lt   "1.3.3"     "1.2.3"
	test_expectFalse    semver_lt   "1.1.3"     "1.0.3"
	test_expectFalse    semver_lt   "1.2.4"     "1.2.3"
	test_expectFalse    semver_lt   "1.2.10"    "1.2.3"
	test_expectFalse    semver_lt   "1.2.3"     "1.0.0"
	test_expectFalse    semver_lt   "3.2.1"     "1.2.3"

	test_expect         semver_lt   "1.2.3"     "10.2.3"
	test_expect         semver_lt   "1.2.3"     "10.0.0"
	test_expect         semver_lt   "1.2.3"     "1.3.3"
	test_expect         semver_lt   "1.0.3"     "1.1.3"
	test_expect         semver_lt   "1.2.3"     "1.2.4"
	test_expect         semver_lt   "1.2.3"     "1.2.10"
	test_expect         semver_lt   "1.0.0"     "1.2.3"
	test_expect         semver_lt   "1.2.3"     "3.2.1"
}

testSemverLE() {
	test_expect         semver_le   "1.2.3"     "1.2.3"
	test_expect         semver_le   "10.20.30"  "10.20.30"
	test_expect         semver_le   "1.0.30"    "1.0.30"

	test_expectFalse    semver_le   "10.2.3"    "1.2.3"
	test_expectFalse    semver_le   "10.0.0"    "1.2.3"
	test_expectFalse    semver_le   "1.3.3"     "1.2.3"
	test_expectFalse    semver_le   "1.1.3"     "1.0.3"
	test_expectFalse    semver_le   "1.2.4"     "1.2.3"
	test_expectFalse    semver_le   "1.2.10"    "1.2.3"
	test_expectFalse    semver_le   "1.2.3"     "1.0.0"
	test_expectFalse    semver_le   "3.2.1"     "1.2.3"

	test_expect         semver_le   "1.2.3"     "10.2.3"
	test_expect         semver_le   "1.2.3"     "10.0.0"
	test_expect         semver_le   "1.2.3"     "1.3.3"
	test_expect         semver_le   "1.0.3"     "1.1.3"
	test_expect         semver_le   "1.2.3"     "1.2.4"
	test_expect         semver_le   "1.2.3"     "1.2.10"
	test_expect         semver_le   "1.0.0"     "1.2.3"
	test_expect         semver_le   "1.2.3"     "3.2.1"
}

test_runTests								\
	testSemverIsValid						\
	testSemverMajor							\
	testSemverMinor							\
	testSemverPatch							\
	testSemverEQ							\
	testSemverGT							\
	testSemverGE							\
	testSemverLT							\
	testSemverLE							\

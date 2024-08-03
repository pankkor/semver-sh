#!/bin/sh

# Simple semver comparison
# For now only MAJOR.MINOR.PATCH format is accepted

semver_regex='^\(0\|[1-9][0-9]*\).\(0\|[1-9][0-9]*\).\(0\|[1-9][0-9]*\)$'

# Return 0 if $1 is semver
semver_is_valid() {
    echo "$1" | grep -q "${semver_regex}"
}

# Get MAJOR version
# semver has to be valid (semver_is_valid)
semver_major() {
    echo "$1" | sed -e "s/${semver_regex}/\1/g"
}

# Get MINOR version
# semver has to be valid (semver_is_valid)
semver_minor() {
    echo "$1" | sed -e "s/${semver_regex}/\2/g"
}

# Get PATCH version
# semver has to be valid (semver_is_valid)
semver_patch() {
    echo "$1" | sed -e "s/${semver_regex}/\3/g"
}

# Semver compare $1 and $2: equal
semver_eq() {
    [ "$1" = "$2" ]
}

# Semver compare $1 and $2: greater than
semver_gt() {
    local major_1="$(semver_major "$1")"
    local minor_1="$(semver_minor "$1")"
    local patch_1="$(semver_patch "$1")"

    local major_2="$(semver_major "$2")"
    local minor_2="$(semver_minor "$2")"
    local patch_2="$(semver_patch "$2")"

    [ "$major_1" -gt "$major_2" ] && return 0
    [ "$major_1" -lt "$major_2" ] && return 1

    [ "$minor_1" -gt "$minor_2" ] && return 0
    [ "$minor_1" -lt "$minor_2" ] && return 1

    [ "$patch_1" -gt "$patch_2" ]
}

# Semver compare $1 and $2: greater than or equal
semver_ge() {
    semver_eq "$1" "$2" || semver_gt "$1" "$2"
}

# Semver compare $1 and $2: less than or equal
semver_le() {
    ! semver_gt "$1" "$2"
}

# Semver compare $1 and $2: less than
semver_lt() {
    ! semver_ge "$1" "$2"
}

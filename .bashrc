
SECONDS_IN_WEEK=
export GPS_UTC_EPOCH_OFFSET_SEC=315964800
# accurate as of 2026
export GPS_LEAP_SECOND_ADJUSTMENT_SEC=18

alias lj="ls *.json"

touche() {
    touch "$1"
    chmod +x "$1"

    if [[ $# -gt 1 ]]; then
        local interpreter="$2"
        echo "#!/usr/bin/env ${interpreter}" > "$1"
    fi
}

# grep only .cpp & .h files
cppgrep() {
    find . \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -exec grep "$@" {} +
}

# wrapper for calling `ls -ltr | cmd`
# -n is the number of files to display (passed to `cmd`)
# -p shows "pretty" output, which just displays the filename and no file info
# for usage with e.g., grep, xargs, etc
shortlist() {
    local cmd="$1"
    shift

    local num_files=""
    local pretty_cmd=""

    local POSITIONAL_ARGS=()
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--pretty)
                pretty_cmd='awk '\''{print $9}'\'
                shift
                ;;
            -n)
                num_files="-$2"
                shift # flag
                shift # value
                ;;
            *)
                POSITIONAL_ARGS+=($1)
                shift
                ;;
        esac
    done

    set -- "${POSITIONAL_ARGS[@]}"
    
    local target="."
    [[ $# -gt 0 ]] && target="$@"

    local ls_cmd="ls -ltr ${target}"
    local display_cmd="${cmd} ${num_files}"

    local full_cmd="${ls_cmd} | ${display_cmd}"
    [[ -n "${pretty_cmd}" ]] && full_cmd="${full_cmd} | ${pretty_cmd}"

    eval "$full_cmd"
}

ltail() {
    shortlist "tail" $@
}

lhead() {
    shortlist "head" $@
}

# convert a unix epoch timestamp to a datetime
dates() {
    date -d "@${1}"
}

# Convert the specified GPS timestamp to UTC time
# By default, expects a GPS timestamp in seconds
# specify -w to convert a GPS timestamp in WWWWSSSSSS format
g2u() {

    # convert WWWWSSSSSS format into UTC timestamp
    if [[ $1 == "-w" ]]; then
        shift;
        local ws=${1:-$(read; echo $REPLY)}

        local WEEK_OFFSET_IN_FORMAT=1000000
        local weeks=$(( ws / WEEK_OFFSET_IN_FORMAT ))
        local secs=$(( ws % WEEK_OFFSET_IN_FORMAT ))
        local SECONDS_IN_WEEK=604800

        t=$(( secs + weeks*SECONDS_IN_WEEK ))
    # convert GPS seconds to UTC seconds
    else
        t=${1:-$(read; echo $REPLY)}
    fi
    local utc_sec=$(( t + GPS_UTC_EPOCH_OFFSET_SEC - GPS_LEAP_SECOND_ADJUSTMENT_SEC ))
    local old_tz="$TZ"
    TZ="UTC" date -d "@${utc_sec}"
}

u2g() {

    local SECONDS_IN_WEEK=604800

    # If nothing was specified, convert the current time
    # For simplicity of argument wrangling, require
    # u2g [-w] [date] syntax
    local utc_now_sec=$(date +%s)
    if [[ $# -eq 1 ]]; then
        utc_now_sec="$1"
        shift
    elif [[ $# -gt 1 ]]; then
        utc_now_sec="$2"
    fi

    local gps_now_sec=$(( utc_now_sec - GPS_UTC_EPOCH_OFFSET_SEC + GPS_LEAP_SECOND_ADJUSTMENT_SEC ))

    if [[ $1 == "-w" ]]; then
        local gps_weeks=$(( gps_now_sec / SECONDS_IN_WEEK ))
        local gps_seconds=$(( gps_now_sec % SECONDS_IN_WEEK ))
        echo "${gps_weeks}${gps_seconds}"
    else
        echo "${gps_now_sec}"
    fi
}

swaps() {
    cmd="-print"
    [[ "$1" == "delete" ]] && cmd="-delete"
    find . -type f -name "*.sw[po]" $cmd
}

PATH=/usr/atria/bin:${PATH}
export PATH

alias ll='ls -latr'
alias lt='ls -lArt'

alias ams='cd /cm_data/onewebams'
alias common='cd /cm_data/onewebcommon'
alias built='cd /cm_data/onewebams/Package/OW_AMS_8.8/bin/x86_64'

#Clearcase aliases
alias ct='cleartool'
alias dev='. ./.profile;cleartool setview lroepe_dev'
alias dep='. ./.profile;cleartool setview lroepe_dep'
alias lsco="cleartool lsco -me -rec -cview"
alias pwv="cleartool pwv"

alias vip="vim -p"


# grep only .cpp & .h files
cpp_grep() {

    command='grep'

    [[ $# -eq 0 ]] && echo "code_grep requires an argument" && return 1
    [[ $# -gt 2 ]] && echo "code_grep takes only a search string and -i (optional)" && return 2

    search_string=$1
    if [[ $# -eq 2 ]]; then

        if [[ $1 == "-i" ]]; then
            
            command="grep -i"
            search_string=$2
        else
            echo "code_grep only takes one search string"
            return 3
        fi
    fi


    files=$(find . -path "./Package" -prune -o -name "*.cpp" -o -name "*.h")
    $command "${search_string}" ${files}
}

# graphical cleartool diff of a file with a base label / the previous version
cdiff() {

    command='cleartool diff -graphical'

    [[ $# -ne 2 ]] && echo "cdiff <file> <base_label>/prev" && return 1
    ! [[ $(ls $1 2>/dev/null) ]] && echo "$1 does not exist" && return 2

    if [[ $2 == "prev" ]]; then
        
        command=$command" -predecessor"

    else

        inFile=$1"@@/main/"$2
        
        ! [[ $(ls ${inFile} 2>/dev/null) ]] && echo "${inFile} does not exist" && return 3

        command="${command} ${inFile}"

    fi

    $command $1

}

# wrapper for ct find
cfind() {
    
    [[ $# -eq 0 ]] && echo "cfind requires an argument (branch name)" && return 1
    [[ $# -ge 2 ]] && echo "cfind only takes one argument (branch name)" && return 2

    ct find . -type file -branch "brtype(${1})" -print
}

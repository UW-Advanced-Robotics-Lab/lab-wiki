#!/usr/bin/env bash

function markdown-toc(){
    local FILE=${1:?No file was specified as first argument}
    
    declare -a TOC
    local CODE_BLOCK=0
    local CODE_BLOCK_REGEX='.*```'
    local CODE_BLOCK_REGEX_PAIR='.*```.*```'
    local HEADING_REGEX='\#{1,}'
    
    while read -r LINE; do
        # Treat code blocks
        if [[ "${LINE}" =~ $CODE_BLOCK_REGEX ]]; then
            # Ignore things until we see code block ending
            CODE_BLOCK=$((CODE_BLOCK + 1))
            # Skip in-line code block
            if [[ "${LINE}" =~ $CODE_BLOCK_REGEX_PAIR ]]; then
                echo "inline code block"
                CODE_BLOCK=0
            fi
            if [[ "${CODE_BLOCK}" -eq 2 ]]; then
                # We hit the closing code block
                CODE_BLOCK=0
            fi
            continue
        fi
    
        # Treat normal line
        if [[ "${CODE_BLOCK}" == 0 ]]; then
            # If we see heading, we save it to ToC map
            if [[ "${LINE}" =~ ${HEADING_REGEX} ]]; then
                TOC+=("${LINE}")
            fi
        fi
    done < <(grep -v '\n# Table of Contents' "${FILE}")
    
    local TOC_TEXT="<toc>\n\n"
    TOC_TEXT+="# Table of Contents\n"
    TOC_TEXT+="[*Last generated: $(date)*]\n"
    for LINE in "${TOC[@]}"; do
        LINK=${LINE}
        # Detect markdown links in heading and remove link part from them
        if grep -qE "\[.*\]\(.*\)" <<< "${LINK}"; then
            LINK=$(sed 's/\(\]\)\((.*)\)/\1/' <<< "${LINK}")
        fi
        # Special characters (besides '-') in page links in markdown
        # are deleted and spaces are converted to dashes
        LINK=$(tr -dc "[:alnum:] _-" <<< "${LINK}")
        LINK=${LINK/ /}
        LINK=${LINK// /-}
        # LINK=${LINK,,}
        LINK=$(tr -s "-" <<< "${LINK}")
    
        # Print in format [Very Special Heading](#very-special-heading)
        case "${LINE}" in
            '#####'*)
                TOC_TEXT+="        - [${LINE#\#* }](#${LINK})\n"
                ;;
            '####'*)
                TOC_TEXT+="      - [${LINE#\#* }](#${LINK})\n"
                ;;
            '###'*)
                TOC_TEXT+="    - [${LINE#\#* }](#${LINK})\n"
                ;;
            '##'*)
                TOC_TEXT+="  - [${LINE#\#* }](#${LINK})\n"
                ;;
            '#'*)
                TOC_TEXT+="- [**${LINE#\#* }**](#${LINK})\n"
                ;;
        esac

    done
    TOC_TEXT+="\n---\n</toc>\n"
    
    { echo -en "${TOC_TEXT}"; cat $FILE; } > $FILE.new
    mv $FILE{.new,}
    echo "    - [x] Generated table of contents"
}
function markdown-eof(){
    local FILE=${1:?No file was specified as first argument}
    local TOC_TEXT="\n<eof>\n"
    TOC_TEXT+="\n---\n"
    TOC_TEXT+="[*> Back To Top <*](#Table of Contents)"
    TOC_TEXT+="\n</eof>"
    { cat $FILE; echo -en "${TOC_TEXT}"; } > $FILE.new
    mv $FILE{.new,}
}

function markdown_toc(){
    local file=${1:?No file was specified as first argument}
    if [[ $file = *"_Sidebar.md" || $file = *"_Footer.md" || $file = *"Home.md" ]]; then
        echo "    - [!] Skip $file"
        continue # skip particular md files
    else
        # now edit toc
        if [[ $(<$file) = *"<toc>"*"</toc>"* ]]; then
        # if [[ $(<$file) = *"# Table of Contents"* ]]; then
            echo "    - [!] Already has a ToC, deleting the old ToC ..."
            sed '/<toc>/,/<\/toc>/d' $file > $file.new
            mv $file{.new,}
            markdown-toc $file
        else
            markdown-toc $file
        fi
        
        # now edit eof
        if [[ $(<$file) = *"<eof>"*"</eof>"* ]]; then
        # if [[ $(<$file) = *"# Table of Contents"* ]]; then
            echo "    - [!] Already has a EoF, deleting the old ToC ..."
            sed '/<eof>/,/<\/eof>/d' $file > $file.new
            mv $file{.new,}
            markdown-eof $file
        else
            markdown-eof $file
        fi
        
        # Append back to top shortcut @ eof
    fi
}

function markdown_toc_directory(){
    local file=${1:?No directory was specified as first argument}
    # markdown batch process:
    if [[ $1 = "-git" ]]; then
        # process only '.md' files from git status
        LIST_OF_MD=($(git diff --name-only | grep -E "\.md$"))
    else
        # process all documents
        LIST_OF_MD=($1/*.md)
    fi 
    
    local n=${#LIST_OF_MD[@]}
    local i=0
    for file in "${LIST_OF_MD[@]}"; do
        i=$(( i + 1 ))
        echo "> [$i/$n] - editing toc @ $file"
        markdown_toc $file
    done
}

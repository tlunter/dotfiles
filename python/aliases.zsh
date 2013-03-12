# Remove python compiled byte-code
function pyclean {
    if [[ -n $1 ]]
    then
        find $1 -type f -name "*.py[co]" -exec rm -f {} \;
    else
        find . -type f -name "*.py[co]" -exec rm -f {} \;
    fi
}

rmx() {
    local usage="Usage: rmx [-v] [-r] [-d directory] [--] file [file ...] [-E exclude-pattern ...] [-G exclude-pattern ...]\n\nOptions:\n  -v\tverbose\n  -r\trecursive\n  -d\tdirectory\n  -E, --regex-pattern\texclude pattern (regular expression)\n  -G, --glob-pattern\texclude pattern (glob pattern)\n\nArguments:\n  file\tfile to delete (glob pattern)"
    local verbose=false
    local recursive=false
    local directory="."
    local files=()
    local regex_exclude_patterns=()
    local glob_exclude_patterns=()
    local state="options"
    
    while [[ $# -gt 0 ]]; do
        case $state in
            options)
                case $1 in
                    --help)
                        echo $usage
                        return 0
                        ;;
                    -v)
                        verbose=true
                        shift
                        ;;
                    -r)
                        recursive=true
                        shift
                        ;;
                    -d)
                        if [[ $# -lt 2 ]]; then
                            echo "Error: missing argument for option -d" >&2
                            echo $usage >&2
                            return 1
                        fi
                        directory=$2
                        shift 2
                        ;;
                    --regex-pattern|-E)
                        state="regex-exclude-patterns"
                        shift
                        ;;
                    --glob-pattern|-G)
                        state="glob-exclude-patterns"
                        shift
                        ;;
                    -*)
                        echo "Error: unknown option $1" >&2
                        echo $usage >&2
                        return 1
                        ;;
                    *)
                        state="files"
                        ;;
                esac
                ;;
            files)
                files+=($1)
                shift
                ;;
            regex-exclude-patterns)
                regex_exclude_patterns+=($1)
                shift
                ;;
            glob-exclude-patterns)
                glob_exclude_patterns+=($1)
                shift
                ;;
        esac
    done
    
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "Error: missing file argument" >&2
        echo $usage >&2
        return 1
    fi
    
    local find_options=()
    if ! $recursive; then find_options+=(-maxdepth 1); fi
    
    local delete_files=()
    for file in "${files[@]}"; do delete_files+=($(find "$directory/$file" "${find_options[@]}")); done
    
    for exclude_pattern in "${regex_exclude_patterns[@]}"; do delete_files=(${delete_files[@]##(e)~$exclude_pattern*}); done 
    for exclude_pattern in "${glob_exclude_patterns[@]}"; do delete_files=(${delete_files[@]##*$exclude_pattern*}); done 
    
    if [[ ${#delete_files[@]} -eq 0 ]]; then return 0; fi
    
    if $verbose; then printf "Files to delete:\n%s\n" "${delete_files[@]}"; fi
    
    printf "Are you sure you want to delete these files? (y/n) "
    local answer=""
    read answer
    
    if [[ $answer != "y" ]]; then return 0; fi
    
    rm "${delete_files[@]}"
}

_rmx() {
    local curcontext="$curcontext" state line expl suf ret=1
    
    _arguments \
        '(- :)'{-h,--help}'[show help information]' \
        '(-v --verbose)'{-v,--verbose}'[verbose]' \
        '(-r --recursive)'{-r,--recursive}'[recursive]' \
        '(-d --directory)'{-d,--directory}'[directory]:directory:_directories' \
        '*:: :->args' && ret=0
    
    case $state in 
        args) 
            if compset -P '*--'; then 
                _files && ret=0 
            else 
                _alternative 'files:file:_files' 'excludes:exclude pattern:()' && ret=0 
            fi 
            ;; 
    esac 
    
    return ret 
} 

compdef _rmx rmx 

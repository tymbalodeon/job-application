set dotenv-load

export PDFS_DIRECTORY := ```
    pdfs_directory="${PDFS_DIRECTORY:-}"
    if [ -n "${pdfs_directory}" ]; then
        mkdir -p "${pdfs_directory}"
    else
        pdfs_directory="$(pwd)"
    fi
    printf "${pdfs_directory}"
```

@_help:
    just --list

# Install TeX pacakge
@install *packages:
    sudo tlmgr install "{{packages}}"

# List install TeX pacakge
@installed:
    sudo tlmgr list --only-installed

_get_files *files:
    #!/usr/bin/env zsh
    if [ -z "{{files}}" ]; then
        files=()
        for file in *.tex(N); do
            if [[ "${file}" != "content.tex" ]] \
                && [[ "${file}" != "functions.tex" ]]; then
                files+="${file}"
            fi
        done
    else
        files=()
        for file in "{{files}}"; do
            files+="${file}".tex
        done
    fi
    if [ -z "${files[*]}" ]; then
        exit
    fi
    printf "${files[@]}"

_clean *files:
    #!/usr/bin/env zsh
    if [ -z "{{files}}" ]; then
        files=(*.tex(N))
    else
        files=({{files}})
    fi
    if [ -z "${files[*]}" ]; then
        exit
    fi
    extensions=(aux log)
    for file in "{{files}}"; do
        for extension in "${extensions[@]}"; do
            rm -f "${PDFS_DIRECTORY}/${file:r}.${extension}"
        done
    done

_get_output_name file:
    #!/usr/bin/env zsh
    file="{{file}}"
    printf "Ben Rosen ${${(C)file:r}/-/ }"

# Create PDF(s) in "${PDFS_DIRECTORY}"
compile *files:
    #!/usr/bin/env zsh
    files=$(just _get_files "{{files}}")
    for file in "${files[@]}"; do
        output_name="$(just _get_output_name "${file}")"
        pdflatex \
            -interaction nonstopmode \
            -halt-on-error \
            -file-line-error \
            -output-directory="${PDFS_DIRECTORY}" \
            -jobname="${output_name}" \
            "${file}" \
            && just _clean "${output_name}"
    done

# List compiled PDFs
compiled:
    #!/usr/bin/env zsh
    for file in "${PDFS_DIRECTORY}"/*.pdf; do
        echo "${file}"
    done

# Open input and output files for <FILE>, compiling on changes
edit file: (compile file)
    #!/usr/bin/env zsh
    files=$(just _get_files "{{file}}")
    echo
    echo
    echo
    echo
    for file in "${files[@]}"; do
        output_name="$(just _get_output_name "${file}")"
        open "${PDFS_DIRECTORY}/${output_name}.pdf"
        open "${file}"
    done
    echo "${files[1]}"
    watchexec \
        --exts tex \
        just compile

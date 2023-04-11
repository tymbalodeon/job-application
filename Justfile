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

@install *packages:
    sudo tlmgr install "{{packages}}"

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

clean *files:
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

compile *files:
    #!/usr/bin/env zsh
    files=$(just _get_files "{{files}}")
    for file in "${files[@]}"; do
        output_name="Ben Rosen ${${(C)file:r}/-/ }"
        pdflatex \
            -interaction nonstopmode \
            -halt-on-error \
            -file-line-error \
            -output-directory="${PDFS_DIRECTORY}" \
            -jobname="${output_name}" \
            "${file}" \
            && just clean "${output_name}"
    done

compiled:
    #!/usr/bin/env zsh
    for file in "${PDFS_DIRECTORY}"/*.pdf; do
        echo "${file}"
    done

edit *files: (compile files)
    #!/usr/bin/env zsh
    files=$(just _get_files "{{files}}")
    for file in "${files[@]}"; do
        extensions=(pdf tex)
        for extension in "${extensions[@]}"; do
            open "${PDFS_DIRECTORY}/${file}.${extension}"
        done
    done
    echo "${files[1]}"
    watchexec \
        --exts tex \
        just compile

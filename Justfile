set dotenv-load

export PDFS_DIRECTORY := ```
    pdfs_directory="${PDFS_DIRECTORY:-}"
    if [ -n "${pdfs_directory}" ]; then
        mkdir -p "${pdfs_directory}"
    fi
    printf "%s" "${pdfs_directory}"
```

@_help:
    just --list

@install *packages:
    sudo tlmgr install "{{packages}}"

clean file:
    #!/usr/bin/env zsh
    extensions=(aux log)
    for extension in "${extensions[@]}"; do
        rm "${PDFS_DIRECTORY}/{{file}}.${extension}"
    done

compile file:
    #!/usr/bin/env zsh
    pdflatex \
        -interaction nonstopmode \
        -halt-on-error \
        -file-line-error \
        -output-directory="${PDFS_DIRECTORY}" \
        "{{file}}".tex \
        && just clean "{{file}}"

edit file: (compile file)
    #!/usr/bin/env zsh
    file_name="${PDFS_DIRECTORY}/{{file}}"
    open "${file_name}.pdf"
    open "${file_name}.tex"
    watchexec \
        --exts tex \
        just compile "{{file}}"

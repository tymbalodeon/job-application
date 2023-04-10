@_help:
    just --list

@install *packages:
    sudo tlmgr install "{{packages}}"

edit file:
    #!/usr/bin/env zsh
    watchexec \
        --exts tex \
        -- pdflatex \
            -interaction nonstopmode \
            -halt-on-error \
            -file-line-error \
            {{file}}.tex

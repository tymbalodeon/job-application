@_help:
    just --list

@install *packages:
    sudo tlmgr install "{{packages}}"

edit:
    #!/usr/bin/env zsh
    watchexec \
        --exts tex \
        -- pdflatex \
            -interaction nonstopmode \
            -halt-on-error \
            -file-line-error \
            *.tex

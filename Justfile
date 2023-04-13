@_help:
    just --list

# Open resume for editing, with live updates
resume:
    open resume.typ \
    && typst watch resume.typ pdfs/resume.pdf --open

# Open resume for editing, with live updates
cover-letter:
    open cover-letter.typ \
    && typst watch cover-letter.typ pdfs/cover-letter.pdf --open

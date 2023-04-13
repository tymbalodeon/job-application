resume_input := "src/resume.typ"
resume_output := "pdfs/resume.pdf"
cover_letter_input := "src/cover-letter.typ"
cover_letter_output := "pdfs/cover-letter.pdf"

@_help:
    just --list

# Open resume for editing, with live updates
resume:
    open {{resume_input}} \
    && typst watch {{resume_input}} {{resume_output}} --open

# Open resume for editing, with live updates
cover-letter:
    open {{cover_letter_input}} \
    && typst watch {{cover_letter_input}} {{cover_letter_output}} --open

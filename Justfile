set dotenv-load

input_directory := "src"
output_directory := ```
    output_directory="pdfs"
    if [ ! -d "${output_directory}" ]; then
        mkdir -p "${output_directory}"
    fi
    printf "%s" "${output_directory}"
```
name := ```
    if [ -f "resume.yaml" ]; then
        yaml_file="resume.yaml"
    else
        yaml_file="resume.example.yaml"
    fi
    name="$(grep "  name:" "${yaml_file}" | awk -F: '{print $2}')"
    name="${name//\"}"
    name="${name/ /}"
    printf "${name}"
```
resume_input := input_directory + "/resume.typ"
resume_output := output_directory + "/" + name + " Resume.pdf"
cover_letter_input := input_directory + "/cover-letter.typ"
cover_letter_output := output_directory + "/" + name + " Cover Letter.pdf"

export PDFS_DIRECTORY := ```
    pdfs_directory="${PDFS_DIRECTORY:-}"
    if [ -n "${pdfs_directory}" ]; then
        mkdir -p "${pdfs_directory}"
    fi
    printf "%s" "${pdfs_directory}"
```

@_help:
    just --list

# Open resume for editing, with live updates
@resume:
    open "{{resume_input}}" \
    && typst watch "{{resume_input}}" "{{resume_output}}" --open

# Open cover-letter for editing, with live updates
@cover-letter:
    open "{{cover_letter_input}}" \
    && typst watch "{{cover_letter_input}}" "{{cover_letter_output}}" --open

# Compile resume and cover-letter
compile *copy:
    #!/usr/bin/env zsh
    typst compile "{{resume_input}}" "{{resume_output}}"
    typst compile "{{cover_letter_input}}" "{{cover_letter_output}}"
    if [ "{{copy}}" = "--copy" ]; then
        pdf_files=("{{resume_output}}" "{{cover_letter_output}}")
        for file in "${pdf_files[@]}"; do
            cp "${file}" "${PDFS_DIRECTORY}"
        done
    fi

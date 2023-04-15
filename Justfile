set shell := ["zsh", "-c"]
set dotenv-load

input_directory := "src"
example_resume := "\\.\\.\\/resume\\.example\\.yaml"
example_cover_letter := "\\.\\.\\/cover-letter\\.example\\.yaml"
source_files := ```
    source_files=()
    for file in src/*.typ; do
        if [[ "${file:t}" != _* ]]; then
            source_files+="${file}"
        fi
    done
    printf "${source_files[*]}"
```
output_directory := ```
    output_directory="${OUTPUT_DIRECTORY:-}"
    if [ -z "${output_directory}" ]; then
        output_directory="build"
    fi
    if [ -n "${output_directory}" ]; then
        mkdir -p "${output_directory}"
    fi
    printf "%s" "${output_directory}"
```
name := ```
    if [ -f "${RESUME}" ]; then
        yaml_file="${RESUME}"
    else
        yaml_file="resume.example.yaml"
    fi
    name="$(grep "  name:" "${yaml_file}" | awk -F: '{print $2}')"
    name="${name//\"}"
    name="${name/ /}"
    printf "${name}"
```

@_help:
    just --list

# Install dependencies
@install:
    ./install_dependencies.sh

_compile file output_file *tags:
    #!/usr/bin/env zsh
    settings="settings.yaml"
    added_tags=()
    for tag in {{tags}}; do
        if ! grep "${tag}" "${settings}" &>/dev/null; then
            added_tag="  - ${tag}"
            added_tags+="${added_tag}"
            echo "${added_tag}" >> "${settings}"
        fi
    done
    if [ -f "${RESUME}" ]; then
        resume="/${RESUME}"
        resume="${resume//\//\\/}"
        sed -i "" "s/{{example_resume}}/${resume}/g" "${settings}"
    fi
    if [ -f "${COVER_LETTER}" ]; then
        cover_letter="/${COVER_LETTER}"
        cover_letter="${cover_letter//\//\\/}"
        sed -i "" \
            "s/{{example_cover_letter}}/${cover_letter}/g" \
            "${settings}"
    fi
    typst compile "{{file}}" "{{output_file}}"
    echo "Compiled {{output_file}}"
    if [ -f "${RESUME}" ]; then
        sed -i "" "s/${resume}/{{example_resume}}/g" "${settings}"
    fi
    if [ -f "${COVER_LETTER}" ]; then
        sed -i "" \
            "s/${cover_letter}/{{example_cover_letter}}/g" \
            "${settings}"
    fi
    for tag in "${added_tags[@]}"; do
        sed -i "" "/${tag}/d" "${settings}"
    done

_get_output_file file:
    #!/usr/bin/env zsh
    output_file="{{file}}"
    output_file="${output_file:t:r}"
    output_file="${(C)output_file/-/ }"
    output_file="{{output_directory}}/{{name}} ${output_file}.pdf"
    output_files+="${output_file}"
    printf "${output_file}"

# Edit {resume|cover-letter} and live preview changes
edit file:
    #!/usr/bin/env zsh
    setopt extendedglob
    source_files=({{source_files}})
    input_file="{{file}}"
    input_file="${input_file:l}"
    for file in "${source_files[@]}"; do
        if [[ "${file:r:t}" = *"${input_file}"* ]]; then
            source_file="${file}"
        fi
    done
    output_file="$(just _get_output_file "${input_file}")"
    open "${source_file}"
    open "${output_file}"
    source_file="\"${source_file}\""
    output_file="\"${output_file}\""
    watchexec --exts typ,yaml -- just _compile "${source_file}" "${output_file}"

# Compile input files [options: "--force", "--open"]
compile *args:
    #!/usr/bin/env zsh
    source_files=({{source_files}})
    output_files=()
    tags=()
    for arg in {{args}}; do
        if [[ "${arg}" != "--"* ]]; then
            tags+="${arg}"
        fi
    done
    for file in "${source_files[@]}"; do
        output_file="$(just _get_output_file "${file}")"
        if [[ "{{args}}" = *"--force"* ]]; then
            just _compile "${file}" "${output_file}" "${tags[*]}"
        else
            checkexec "${output_file}" \
            -- just _compile "${file}" "${output_file}" "${tags[*]}"
        fi
    done
    if [[ "{{args}}" = *"--open"* ]]; then
        just open
    fi

# List output files
list:
    #!/usr/bin/env zsh
    output_files=("{{output_directory}}"/*.pdf(N))
    for file in "${output_files[@]}"; do
        echo "${file}."
    done

# Open output files
open:
    #!/usr/bin/env zsh
    for file in "{{output_directory}}"/*.pdf(N); do
        open "${file}"
    done

# Remove output files
clean:
    #!/usr/bin/env zsh
    output_files=("{{output_directory}}"/*.pdf(N))
    for file in "${output_files[@]}"; do
        rm -f "${file}"
        echo "Removed ${file}."
    done


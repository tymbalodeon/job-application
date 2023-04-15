set shell := ["zsh", "-c"]
set dotenv-load

input_directory := "src"
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

@_help:
    just --list

@_compile file output_file:
    typst compile "{{file}}" "{{output_file}}"
    echo "Created {{output_file}}"

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
    output_files=("{{output_directory}}"/*(#i)"${input_file}"*.pdf(N))
    for file in "${output_files}"; do
        output_file="${file}"
    done
    open "${output_file}"
    open "${source_file}"
    typst watch "${source_file}" "${output_file}"


# Compile input files
compile:
    #!/usr/bin/env zsh
    source_files=({{source_files}})
    output_files=()
    for file in "${source_files[@]}"; do
        output_file="${file:t:r}"
        output_file="${(C)output_file/-/ }"
        output_file="{{output_directory}}/{{name}} ${output_file}.pdf"
        output_files+="${output_file}"
        checkexec "${output_file}" -- just _compile "${file}" "${output_file}"
    done

# List output files
list:
    #!/usr/bin/env zsh
    output_files=("{{output_directory}}"/*.pdf(N))
    for file in "${output_files[@]}"; do
        echo "${file}."
    done

# Remove output files
clean:
    #!/usr/bin/env zsh
    output_files=("{{output_directory}}"/*.pdf(N))
    for file in "${output_files[@]}"; do
        rm -f "${file}"
        echo "Removed ${file}."
    done


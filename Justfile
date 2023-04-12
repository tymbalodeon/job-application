@_help:
    just --list

tectonic := "tectonic -X"

_get_tectonic_directories *file:
    #!/usr/bin/env zsh
    setopt extendedglob
    if [[ -n *"{{file}}"*(#qN) ]]; then
        directories=(
            $(find *"{{file}}"* \
                -type f \
                -name "Tectonic.toml" \
                | sed -E "s|/[^/]+$||" \
                | uniq
            )
        )
    else
        directories=()
    fi
    printf "${directories[*]}"

# Build all files
build *files:
    #!/usr/bin/env zsh
    setopt extendedglob
    if [ -z "{{files}}" ]; then
        tectonic_directories=($(just _get_tectonic_directories))
    else
        files=({{files}})
        tectonic_directories=()
        for file in "${files[@]}"; do
            directories=($(just _get_tectonic_directories "${file}"))
            tectonic_directories+="${directories}"
        done
    fi
    if [ "${tectonic_directories[*]}" -eq 0 ]; then
        exit
    fi
    base_directory="$(pwd)"
    for directory in "${tectonic_directories[@]}"; do
        cd "${base_directory}/${directory}"
        {{tectonic}} build
    done

# Open file for editing and view output, recompiling on changes
edit file: (build file)
    #!/usr/bin/env zsh
    setopt extendedglob
    pdf_files=(*"{{file}}"*/**/*.pdf(N))
    if [ -n "${pdf_files[*]}" ]; then
        for file in "${pdf_files[@]}"; do
            open "${file}"
        done
    fi
    tex_files=(*"{{file}}"*/src/index.tex(N))
    if [ -n "${tex_files[*]}" ]; then
        for file in "${tex_files[@]}"; do
            open "${file}"
        done
    fi
    {{tectonic}} watch

# Remove <FILE> pdf
clean file:
    #!/usr/bin/env zsh
    cd "{{file}}"
    rm -f **/**.pdf

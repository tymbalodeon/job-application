@_help:
    just --list

tectonic := "tectonic -X"

# Build all files
build:
    #!/usr/bin/env zsh
    IFS=$'\n'
    tectonic_directories=(
        $(find . \
            -type f \
            -name "Tectonic.toml" \
            | sed -E "s|/[^/]+$||" \
            | uniq
        )
    )
    base_directory="$(pwd)"
    for directory in "${tectonic_directories[@]}"; do
        cd "${base_directory}/${directory/.\//}"
        {{tectonic}} build
    done

compile file:
    #!/usr/bin/env zsh
    cd "{{file}}"
    {{tectonic}} build

# Open file for editing and view output, recompiling on changes
edit file: (compile file)
    #!/usr/bin/env zsh
    cd "{{file}}"
    pdf_files=(**/**.pdf(N))
    if [ -n "${pdf_files[*]}" ]; then
        for file in "${pdf_files[@]}"; do
            open "${file}"
        done
    fi
    tex_files=(**/**index.tex(N))
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

@_help:
    just --list

# build all files
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
        tectonic -X build
    done

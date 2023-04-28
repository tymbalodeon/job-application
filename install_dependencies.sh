#!/usr/bin/env sh

dependencies=(
    "brew"
    "just"
    "cargo"
    "checkexec"
    "typst"
    "watchexec"
    "skim"
)

install_dependency() {
    case "${1}" in
        "brew")
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
            ;;
        "just")
            brew install just
            ;;
        "cargo")
            curl https://sh.rustup.rs -sSf | sh
            ;;
        "checkexec")
            cargo install checkexec
            ;;
        "watchexec")
            brew install watchexec
            ;;
        "Skim")
            mdfind -name "kMDItemFSName == '*.app'" | grep "Skim"
            ;;
        "typst")
            brew install typst
            ;;
    esac
}

check_dependency() {
    if [ "${1}" = "skim" ]; then
        if mdfind -name "kMDItemFSName == '*.app'" | grep "Skim" &>/dev/null; then
            echo '"Skim" already installed.'
        else
            echo "Installing Skim..."
            install_dependency "Skim"
        fi
    else
        if command -v "${1}" &>/dev/null; then
            echo "\"${1}\" already installed."
        else
            echo "Installing ${1}..."
            install_dependency "${1}"
        fi
    fi
}

for dependency in "${dependencies[@]}"; do
    check_dependency "${dependency}"
done


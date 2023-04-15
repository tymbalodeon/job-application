# Job Application

Manage resumes and cover letters created with [Typst](https://typst.app/docs).

# Dependencies

- [Typst](https://typst.app/docs)
- [checkexec](https://github.com/kurtbuilds/checkexec "checkexec")
- [watchexec](https://watchexec.github.io/ "watchexec")
- [skim](https://skim-app.sourceforge.io/ "skim")

Dependencies can be installed by running the included script:
`./install_dependencies`

Or, if `just` is already installed: `just install` to install the rest of the
dependencies.

## Tasks

Task scripts are provided using [`just`](https://just.systems/man/en/ "just"). Available commands:

- `clean`: Remove output files
- `compile \*args`: Compile input files
- `edit file`: Edit \<FILE\> and live preview changes
- `install`: Install dependencies
- `list`: List output files
- `open`: Open output files

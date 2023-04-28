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

Task scripts are provided using [`just`](https://just.systems/man/en/ "just").
Available commands:

- `clean`: Remove output files
- `compile \*args`: Compile input files [options: "--force", "--open"]
- `edit file`: Edit {resume|cover-letter}, compiling using \<TAGS\> on changes
- `example *open`: Compile and optionally open example files
- `install`: Install dependencies
- `list`: List output files
- `open`: Open output files

## Usage

### Example

The output style can be viewed using example data by running `just example --open`.

### Add your own data

The contents of your resume and cover letter are read from content files written
in [yaml](https://yaml.org/). The required format is modeled in
`cover-letter.example.yaml` and `resume.example.yaml`. Copy `.env.example` to
`.env`, replacing the values with the path to your resume and/or cover letter
content file (which can be anywhere on your machine), and optionally the path to
an output folder outside of the project directory, and run `just edit
{resume|cover-letter}>` to open a file for editing and compiling on changes, or
`just compile` to compile only.

_Note: Paths must be full paths, NOT relative paths!_

### Tags

Resume content can be tagged with keywords to allow for compiling different
versions from the same content source. For example, you could tag some content
so that it is only included in an "long" version, or in a version meant to
emphasize a particular aspect of your background. Content without any tags will
always be included and content with one or more tags will only be included if
either no tags are targeted at compilation or if all of the content's tags are
targeted. Consult the `*.example.yaml` files to see how tags should be
specified. Run `just compile <TAG> ...` to compile output targeting specific
tags only.

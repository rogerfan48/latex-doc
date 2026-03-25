# latex-doc

A personal LaTeX document template with pre-configured styles, macros, and a project scaffolding tool.

## Quick Start

### 1. Source the script

Add the following line to your `~/.zshrc`:

```bash
source /path/to/latex-doc/scripts/newtex.sh
```

### 2. Create a new project

```bash
newtex my-report
```

This creates the following structure:

```
my-report/
├── main.tex        # Main document (edit this)
├── preamble.tex    # Package loading & configuration
├── macros.tex      # Style system & custom commands
├── .gitignore      # LaTeX + macOS ignore rules
├── .chktexrc       # chktex linter configuration
└── assets/         # Place images here
```

Use `-r` or `--ref` to include a reference/cheatsheet file:

```bash
newtex my-report --ref
```

This additionally copies `ref.tex`, which demonstrates all available features.

## Available Styles

Set the style in `main.tex` with `\usestyle{name}`:

| Style | Description |
|---|---|
| `academic` | Centered title, numbered sections with underline, page number footer |
| `homework` | Left-right title layout (title + course left, date + author right), unnumbered sections, header with `\docheader` (defaults to subtitle) and author |
| `note` | Left-aligned 24pt title, author · date inline, numbered sections with underline, header with `\docheader` (defaults to title) and author |
| `minimal` | Left-aligned title, unnumbered sections, clean and simple |
| `custom` | Based on `academic`, override with your own `\titleformat` calls |

## Features

- **Style system** — Switch between document layouts with a single command
- **Code blocks** — Dark-themed syntax-highlighted code via `codeblock` environment
- **Inline code** — Rounded background pill via `\inlinecode{}`
- **Callout boxes** — `bluebox`, `amberbox`, `greenbox`, `redbox` with optional custom titles
- **Blockquote** — Left-bordered italic quote block
- **Theorem environments** — `theorem`, `definition`, `lemma`, `corollary`, `proposition`
- **Algorithm** — `algorithm2e` with pre-configured styling
- **Multi-column** — `twocol` and `threecol` environments
- **Todo notes** — `\todox{}`, `\todomark{}`, `\tododone{}`
- **Margin notes** — `\marginmark{}`

## Notes on Display Math Spacing

Manual `\setlength{\parskip}{...}` causes excessive vertical space around display math (`align*`, `\[...\]`, etc.) because LaTeX adds `\parskip` on top of `\abovedisplayskip` at every implicit paragraph break. This template uses the `parskip` package instead, which handles these interactions automatically.

Additionally, `\abovedisplayskip` (~14pt at 12pt font) is reduced to 4pt via `\appto\normalsize` — necessary because `\normalsize` resets display skips on every call, overriding any direct `\setlength`.

**Writing tip:** Avoid placing display math directly after a section heading with no text in between — it creates an empty paragraph that adds a full `\baselineskip` (~17pt) of unwanted space. Always add at least a short introductory line.

## Compilation

Compile with LuaLaTeX:

```bash
lualatex --shell-escape main.tex
```

For bibliography support:

```bash
lualatex --shell-escape main.tex
biber main
lualatex --shell-escape main.tex
lualatex --shell-escape main.tex
```

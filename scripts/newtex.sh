#!/usr/bin/env bash
# newtex.sh — Quickly scaffold a new LaTeX project from the latex-doc template.
#
# Source this file in your .zshrc:
#   source /path/to/latex-doc/scripts/newtex.sh
#
# Usage:
#   newtex <project-name> [-r|--ref]

# Resolve the template directory relative to this script
_NEWDOC_TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"

newtex() {
    local ref=false
    local name=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -r|--ref)
                ref=true
                shift
                ;;
            -h|--help)
                echo "Usage: newtex <project-name> [-r|--ref]"
                echo ""
                echo "Create a new LaTeX project directory with template files."
                echo ""
                echo "Options:"
                echo "  -r, --ref    Include ref.tex (template reference/cheatsheet)"
                echo "  -h, --help   Show this help message"
                return 0
                ;;
            -*)
                echo "newtex: unknown option '$1'" >&2
                echo "Usage: newtex <project-name> [-r|--ref]" >&2
                return 1
                ;;
            *)
                if [[ -z "$name" ]]; then
                    name="$1"
                else
                    echo "newtex: unexpected argument '$1'" >&2
                    return 1
                fi
                shift
                ;;
        esac
    done

    if [[ -z "$name" ]]; then
        echo "newtex: project name is required" >&2
        echo "Usage: newtex <project-name> [-r|--ref]" >&2
        return 1
    fi

    if [[ -e "$name" ]]; then
        echo "newtex: '$name' already exists" >&2
        return 1
    fi

    local tpl="$_NEWDOC_TEMPLATE_DIR"

    # Verify template directory
    if [[ ! -f "$tpl/main.tex" ]]; then
        echo "newtex: template not found at $tpl" >&2
        return 1
    fi

    # Create project structure
    mkdir -p "$name/assets"
    cp "$tpl/main.tex"     "$name/"
    cp "$tpl/macros.tex"   "$name/"
    cp "$tpl/preamble.tex" "$name/"
    cp "$tpl/.gitignore"   "$name/"
    cp "$tpl/.chktexrc"    "$name/"
    cp "$tpl/.latexindent.yaml" "$name/"

    if $ref; then
        cp "$tpl/ref.tex" "$name/"
    fi

    echo "Created LaTeX project: $name/"
    echo "  main.tex, preamble.tex, macros.tex, .gitignore, .chktexrc, .latexindent.yaml, assets/"
    if $ref; then
        echo "  ref.tex (reference included)"
    fi
}

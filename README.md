# Stella Homebrew tap

Homebrew tap for the [Stella CLI](https://github.com/oxageninc/stella-cli) — a
fast, BYOK, model-agnostic terminal coding agent.

## Install

```bash
brew install macanderson/tap/stella
# equivalently: brew tap macanderson/stella && brew install stella
```

Upgrade with `brew upgrade stella`.

## What's here

`Formula/stella.rb` is **generated** — the Stella CLI's
[`release` workflow](https://github.com/oxageninc/stella-cli/blob/main/.github/workflows/release.yml)
renders it from `.github/homebrew/stella.rb.tmpl` on every `v*` tag and commits
it here with the real per-platform binary URLs and SHA-256 sums. Don't edit
`Formula/stella.rb` by hand; change the template in `stella-cli` instead.

Prefer no Homebrew? A `curl | sh` installer is available:

```bash
curl -fsSL https://raw.githubusercontent.com/oxageninc/stella-cli/main/install.sh | sh
```

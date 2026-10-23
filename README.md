# neo-the-on3/homebrew-tap

Homebrew formulae for [neo-the-on3](https://github.com/neo-the-on3)'s tools.

## reminders

[reminders](https://github.com/neo-the-on3/reminders) is a fast, native command-line tool and MCP server for Apple
Reminders. It needs macOS 26 or later and is a universal binary (Apple silicon and Intel).

```sh
brew install neo-the-on3/tap/reminders
reminders authorize
```

It's an alpha pre-release, ad-hoc signed and not notarized. The first run asks for Reminders access. Under an
MCP client the prompt names `reminders`; from a terminal it names the terminal app. To use it as an MCP server,
point the client at `$(brew --prefix)/bin/reminders --mcp`.

## Updating the formula

When reminders publishes a release:

```sh
git switch -c bump-reminders-<version>
scripts/bump-formula.sh <version>     # e.g. 0.1.0-alpha.2
git commit -am "reminders <version>" && gh pr create --fill
```

The script reads the release's `.sha256`, checks it against the downloaded tarball, and updates `url` and `sha256`
in `Formula/reminders.rb` (Homebrew reads the version from the url). Bumps go through pull requests.

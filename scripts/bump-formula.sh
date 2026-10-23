#!/usr/bin/env bash
# Points Formula/reminders.rb at a reminders release: updates version, url and sha256.
#
#   scripts/bump-formula.sh <version>        # e.g. 0.1.0-alpha.2 (no leading v)
#
# Reads the release's published .sha256, downloads the tarball and checks it matches before editing anything.
# Only edits the local file; commit it on a branch and open a pull request.
set -euo pipefail

version=${1:?usage: $0 <version>}
version=${version#v}
cd "$(dirname "$0")/.."
formula=Formula/reminders.rb
package="reminders-$version-macos-universal.tar.gz"
url="https://github.com/neo-the-on3/reminders/releases/download/v$version/$package"

sha256() { if command -v sha256sum >/dev/null; then sha256sum "$1"; else shasum -a 256 "$1"; fi | cut -d' ' -f1; }

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
curl -fsSL -o "$work/$package" "$url"
curl -fsSL -o "$work/$package.sha256" "$url.sha256"
published=$(cut -d' ' -f1 <"$work/$package.sha256")
actual=$(sha256 "$work/$package")
if [[ $published != "$actual" ]]; then
  echo "error: $package hashes to $actual, but its .sha256 says $published" >&2
  exit 1
fi

perl -pi -e "s|^  url \".*\"|  url \"$url\"|; s|^  version \".*\"|  version \"$version\"|; s|^  sha256 \".*\"|  sha256 \"$actual\"|" "$formula"
grep -q "sha256 \"$actual\"" "$formula" && grep -q "version \"$version\"" "$formula"
echo "Formula/reminders.rb -> $version ($actual)"

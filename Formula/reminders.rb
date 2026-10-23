class Reminders < Formula
  desc "Fast native CLI and MCP server for Apple Reminders"
  homepage "https://github.com/neo-the-on3/reminders"
  url "https://github.com/neo-the-on3/reminders/releases/download/v0.1.0-alpha.1/reminders-0.1.0-alpha.1-macos-universal.tar.gz"
  sha256 "3be92137069159e1517f04a0124883a4a78554288b2b4c6ac2271282b77de08d"
  license "MIT"

  depends_on macos: :tahoe

  def install
    bin.install "reminders"
  end

  def caveats
    <<~EOS
      reminders needs access to Apple Reminders. Grant it with:
        reminders authorize
      Under an MCP client such as Claude Desktop, macOS asks about "reminders" itself;
      from a terminal it asks about the terminal app.

      To use it as an MCP server, point your client at:
        #{opt_bin}/reminders --mcp
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/reminders --version").strip
  end
end

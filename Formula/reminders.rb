class Reminders < Formula
  desc "Fast native CLI and MCP server for Apple Reminders"
  homepage "https://github.com/neo-the-on3/reminders"
  url "https://github.com/neo-the-on3/reminders/releases/download/v0.1.0-alpha.2/reminders-0.1.0-alpha.2-macos-universal.tar.gz"
  sha256 "89e0b2d32430ed858320e4466be1d3bbf477f9be167bb6293142efbca62307cf"
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

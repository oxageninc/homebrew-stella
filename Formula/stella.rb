# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.65 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.4.65"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.65/stella-0.4.65-aarch64-apple-darwin.tar.gz"
      sha256 "2d312aa653f4d8e65ec85a050133ff4af484acf61ce4c68d5677242acbec25a8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.65/stella-0.4.65-x86_64-apple-darwin.tar.gz"
      sha256 "8435f11e27b0fca0953d0fcdbb660ef14d93a24eb868a8c99f2867b2ca173891"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.65/stella-0.4.65-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dbbb43c733e1d70123001ddd96005d481af7a63c0f47a579028a7ec8b5f7e400"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.65/stella-0.4.65-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9baaeabdd74f2b19e3a0c27927a85cecc4cf3f9ccba7c2bdc4d4a21f05a6d18"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end

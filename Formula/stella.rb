# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.2.0 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (oxageninc/homebrew-stella) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/oxageninc/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.0/stella-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "91e7c22accc66b43526bddbe821c2a73340cc3ba144c2ce16142aa1460486bb9"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.0/stella-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "bb2aa769806f6906d0d23f69570b7735c654422e15b8828650c67f655c118340"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.0/stella-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c51b60e6ec98794b2c247e0ff1636463a40c87f727e45c18208519c26104d4f5"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.0/stella-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "664bb43442a0bbc9b5a106a8039ec6275c1acddb44e95264707b9461f5b86fc7"
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

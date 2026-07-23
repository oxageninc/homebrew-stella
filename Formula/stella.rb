# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.73 / @SHA_*@ placeholders below with
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
  version "0.4.73"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.73/stella-0.4.73-aarch64-apple-darwin.tar.gz"
      sha256 "ab95ed59aaf97015d294da381aba4e17ba75b8d24839a3cdf0ea14a62daa0620"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.73/stella-0.4.73-x86_64-apple-darwin.tar.gz"
      sha256 "5a9920c8d0ada9b9f8c1c874b7585cda94ea9c6f574a9a1169832597882c560e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.73/stella-0.4.73-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e9b928cf19916e102e915da87ac3fd6fc2137dd47e0cd6bb1eaadf0511edf05c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.73/stella-0.4.73-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d98a49b1375d3466240aa1ff3e964225a1e9e413f3497e4c03f15dde4b956cec"
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

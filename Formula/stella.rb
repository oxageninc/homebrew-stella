# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.6 / @SHA_*@ placeholders below with
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
  version "0.3.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.6/stella-0.3.6-aarch64-apple-darwin.tar.gz"
      sha256 "2e0a246a208eeb1c2bee8acd9e2a255e4ddcb40f6da6adf69c376d96268001a4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.6/stella-0.3.6-x86_64-apple-darwin.tar.gz"
      sha256 "a7834b7e0ebe385b54c3299167f51d62ce68696951d58e65a9fa0471847f7442"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.6/stella-0.3.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e9c266fbb1c7b4150db752d19216233ca7cbaa56dca4c1f2d041cbe483ec9c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.6/stella-0.3.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f3b683b12acb7fa581845892c3381ce42a2ceb556d580bf21e176ca2d281c108"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.1.15 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (oxageninc/homebrew-stella) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/oxageninc/stella"
  version "0.1.15"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.15/stella-0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "bc42fcfc6363f00b5950cde2c3f09b6324f957a3b5fe8f2373cb71c9b569067b"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.15/stella-0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "cb1957ae3d10e6badaee8b707a8ea7774bd6768e6591f83359b7c5662542e6de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.15/stella-0.1.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a0c399352ff6798ba06f03640519687bfbd0b3848535b39079f21a7dce2263b"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.15/stella-0.1.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0b246c6a2ac87e956219001a39b82ddd99dd57d0510a9b357fef1cfc6ea1a57"
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

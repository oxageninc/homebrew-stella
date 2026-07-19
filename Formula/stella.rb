# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.36 / @SHA_*@ placeholders below with
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
  version "0.4.36"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.36/stella-0.4.36-aarch64-apple-darwin.tar.gz"
      sha256 "95a880cab19ec8973d21b2a57308dcf3cf9f0c63564b39de73be51ddf96c131e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.36/stella-0.4.36-x86_64-apple-darwin.tar.gz"
      sha256 "dfa8ffc83819486a5feb70a7cd37a705a75059276381d70fcdb4fef0480597ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.36/stella-0.4.36-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a41dfd5d1c9c79f7a08ac3b21866108ceba0378be854d2f7d0e4edf6fe599100"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.36/stella-0.4.36-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5914af467f1cac45355908caadd1335f73ff92587d5d91bdaa97817a7c531ca4"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.58 / @SHA_*@ placeholders below with
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
  version "0.4.58"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.58/stella-0.4.58-aarch64-apple-darwin.tar.gz"
      sha256 "acd7c8f36757787952065c6f76516c28f353641136fae116e56a8ca31cea54f3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.58/stella-0.4.58-x86_64-apple-darwin.tar.gz"
      sha256 "997a4a7b36bf17b85801a5de5aaad90475aaa842fba9888bd52b52a39d7924c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.58/stella-0.4.58-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c449a815ece886607961db0a1a7d15d1d40dd9e34a0f745543a2af29fbeee459"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.58/stella-0.4.58-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a41ee56a623833451a3d517e3ee37a4fcdafc69b8e23f320a363ad0d9eca27e"
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

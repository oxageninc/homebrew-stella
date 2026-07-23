# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.85 / @SHA_*@ placeholders below with
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
  version "0.4.85"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.85/stella-0.4.85-aarch64-apple-darwin.tar.gz"
      sha256 "b91447ebd0e09dfc40df1b3ce3106ae0c6abbd4888791dc6f89c35484956831b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.85/stella-0.4.85-x86_64-apple-darwin.tar.gz"
      sha256 "095b39da5505c426d7fff9ed6b4c6787ce7d1e9c521e4e0f87867b8479d17a38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.85/stella-0.4.85-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "544c038b308f05427bb9dd0b7ef8b1cff1e6f623f7489014f53caac3a5865b79"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.85/stella-0.4.85-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e676fa5b8efc341cdfe2d8f6da2815a2fb3f768b9535c81f9398d6c70deb6b39"
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

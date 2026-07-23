# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.83 / @SHA_*@ placeholders below with
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
  version "0.4.83"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.83/stella-0.4.83-aarch64-apple-darwin.tar.gz"
      sha256 "4ec473a7181ed31393de8f98fe9dfdcb13028ceb980ae99a746c1243a87332ed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.83/stella-0.4.83-x86_64-apple-darwin.tar.gz"
      sha256 "86ec8731cc71a2a07932c3809e1e6df975bd028d42a9023a7492f2d68209bbd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.83/stella-0.4.83-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e151121bf70f9bde3bfa44ffc33852d9b7e0b325f57d41c5ef18616f87bc185"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.83/stella-0.4.83-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "389c16b0f903841dd8827640eb49fec40e3d1513eda52f0a580717d715e9d281"
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

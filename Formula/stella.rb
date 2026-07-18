# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.15 / @SHA_*@ placeholders below with
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
  version "0.4.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.15/stella-0.4.15-aarch64-apple-darwin.tar.gz"
      sha256 "181d1359151254ee93e7c327c703363358983620df9378c98faa041050fa5b31"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.15/stella-0.4.15-x86_64-apple-darwin.tar.gz"
      sha256 "844fca0885e773757ade83869ca20215893dc36cd89f39fc6bfabd2c888fc90a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.15/stella-0.4.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd1f2e3270856f457fc14448c1f72ef5aeaeb7b9d5b21d343a9fc6883ce24fb3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.15/stella-0.4.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0737aa77fca800d1701c7c74b0f4370b71be0ecac9661bb590cdec48b0d30169"
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

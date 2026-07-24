# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.5 / @SHA_*@ placeholders below with
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
  version "0.5.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.5/stella-0.5.5-aarch64-apple-darwin.tar.gz"
      sha256 "2c94e6bc66d14c9a6c90fa419a6f20966e6b1e779b34bb6647c8c0bb860fdc43"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.5/stella-0.5.5-x86_64-apple-darwin.tar.gz"
      sha256 "a67a319316fa7da4598b33d5faa6f426a4db89fbdd451877f5fcea48ce187111"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.5/stella-0.5.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "642d33e368e3aa5bb7b946220a11e198ddd48d6d603d0b76c61adb1993bba759"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.5/stella-0.5.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9359ba3aeaada2a7967473cf1e1e677808a0915c49c1e14437e589ae03f6dff"
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

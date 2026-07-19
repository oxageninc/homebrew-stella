# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.18 / @SHA_*@ placeholders below with
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
  version "0.4.18"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.18/stella-0.4.18-aarch64-apple-darwin.tar.gz"
      sha256 "7a6f84447f72da4b48eed2887222a922569e8a97811dae4035532565fb028fce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.18/stella-0.4.18-x86_64-apple-darwin.tar.gz"
      sha256 "ecc4f13742ef48e5809bbdf675016ae2b7dfb7da26edacc9abe1f738e7aa5ffb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.18/stella-0.4.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "76d3749dca4619e9cca23a11bccce9a7753a815d727ac5f306d7f4d4ac149f6b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.18/stella-0.4.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5e2198dcfdd87bf8658e34f85e0f5e99c0d149e9bf1402cf7ab090e06886543"
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

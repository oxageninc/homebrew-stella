# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.0 / @SHA_*@ placeholders below with
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
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.0/stella-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "5c3002fd88fa4a9360df46c40489f1f3de3382a73004f7a7a11ac1b1ed5c1ce8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.0/stella-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "d417bbde914ed81fdf6e404a75c57db6ccee5777e2944d0d840fb9614d6c92e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.0/stella-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "18808926d69eea04784bf9b2353b10fbd3edf9c9b8b014a4ae7f526e15fd2648"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.0/stella-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05ccbdd62309c3ec09cbf428e44355859ad6e8aa710f1ed45354ee047f25fb7f"
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

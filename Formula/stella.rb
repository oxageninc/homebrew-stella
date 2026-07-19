# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.34 / @SHA_*@ placeholders below with
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
  version "0.4.34"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.34/stella-0.4.34-aarch64-apple-darwin.tar.gz"
      sha256 "cf4f78183906ffed27b869430cfd93bb86a8f9627c0d092845e0f43881db5b92"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.34/stella-0.4.34-x86_64-apple-darwin.tar.gz"
      sha256 "5e14483b8c33bfca2f7924656e617e3bbbdf19a25f020fe2a95972599c20e676"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.34/stella-0.4.34-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "545a48bb719edb0b242034db6efb1a67006b9dced60554f5c379afef8e667b72"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.34/stella-0.4.34-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "400f6fa904f084a914a9653f4296c4fb2046bb8abd2b9f4130907cf1b79ac6c5"
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

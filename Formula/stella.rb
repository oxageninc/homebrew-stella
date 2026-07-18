# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.11 / @SHA_*@ placeholders below with
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
  version "0.4.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.11/stella-0.4.11-aarch64-apple-darwin.tar.gz"
      sha256 "2f4538b0a14adb29584b3a0627de36083e026d30bb7d3dd6d35e3863bd22dac2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.11/stella-0.4.11-x86_64-apple-darwin.tar.gz"
      sha256 "989cac978d3070b50ca5d4a504254fe44c40c2b8f94646ff3d5535d1a333b0a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.11/stella-0.4.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25808d5e6527e5c2c770e334b38bbc2c1b7a13a110d060474507cbac8138a43c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.11/stella-0.4.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82f10f0d64da7d84f1b371aa913121c820dd00b50d1c72ce8b3c584543b97ff8"
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

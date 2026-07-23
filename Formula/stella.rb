# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.0 / @SHA_*@ placeholders below with
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
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.0/stella-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "0995aead92635c89be735f99db4b6b394d036f6c8d4c98e5959bc38f7734f6cb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.0/stella-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "bf5faa145dc02cfdfc348d96c88681008f0c5b658699eec183dc4c9e393f2f2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.0/stella-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e90da9c5ec23e9eb209e93ccaac9423894e123939958f2b28a0b0a52914a9575"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.0/stella-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e1b5cca9848b495e0270defdf412e4d74b20c10312d732c348930e932ec3c63"
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

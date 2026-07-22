# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.69 / @SHA_*@ placeholders below with
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
  version "0.4.69"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.69/stella-0.4.69-aarch64-apple-darwin.tar.gz"
      sha256 "198ef842f90c2057cc810a7820a80b6d28547d9038299764b402f5cc0bab6935"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.69/stella-0.4.69-x86_64-apple-darwin.tar.gz"
      sha256 "1f15cd0792049a1b7896f21cdfdddfe85dc638f340a2ab68f116acd8e9ff4b4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.69/stella-0.4.69-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50a0e2771e10885aff1f286aa3f9b3a4307da42bf215473f97669029b44c1f6d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.69/stella-0.4.69-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2639bffa68eae0a753a6241a7d36b0a20bad4cb5c97de7ff6e0efab79bdb29c"
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

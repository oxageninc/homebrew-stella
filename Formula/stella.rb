# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.67 / @SHA_*@ placeholders below with
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
  version "0.4.67"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.67/stella-0.4.67-aarch64-apple-darwin.tar.gz"
      sha256 "d2f7186c377ca8572926a76359b39f58af80570eb30ca461282af2824fae738d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.67/stella-0.4.67-x86_64-apple-darwin.tar.gz"
      sha256 "6a2f30499d1da6bb84bd96ea3481fa562031623435d7f9a3d39cd9b57c32d316"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.67/stella-0.4.67-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ae69b44720e88437cb5b3179fb3f7dfc0363e058bc3afef8c92f099b03694e62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.67/stella-0.4.67-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "acdfa3ea0648a05422dc0acb8ff53c6df0ed41e47d59c89999ec009dbff0eb0a"
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

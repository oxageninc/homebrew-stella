# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.72 / @SHA_*@ placeholders below with
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
  version "0.4.72"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.72/stella-0.4.72-aarch64-apple-darwin.tar.gz"
      sha256 "6a09a783923065750d01b993c9b2601de0a5b74de049f1c8509adaed877b327b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.72/stella-0.4.72-x86_64-apple-darwin.tar.gz"
      sha256 "10bfb6e26ecfb57677fd6153539c81772b17f1ba28457767eb9aca0d1b0ac873"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.72/stella-0.4.72-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "94c74bd12a01e384eba8c830fff3c1eb48223f11e059d7f791282a617585d6fc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.72/stella-0.4.72-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "196b3a0bcb8028537158965e8651a52b75e444ef4437267f1446d26e83f4f1c0"
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

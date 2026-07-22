# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.59 / @SHA_*@ placeholders below with
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
  version "0.4.59"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.59/stella-0.4.59-aarch64-apple-darwin.tar.gz"
      sha256 "e4c3e9043d45090d0ee1b196c9c66ff99254a32017d29fd60880dacdfee91385"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.59/stella-0.4.59-x86_64-apple-darwin.tar.gz"
      sha256 "bfd400d1a7363d8a89d3afcad281363fdcef6467aad7c9285cde3062482cd5db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.59/stella-0.4.59-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b4925a62d3c45009f6e7e3eb9774d040a1d3bf672673539b591f05cb74d1fc7f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.59/stella-0.4.59-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e96f24e5cde96185db074ded64c17441b8d1d5103f4cad8075eb87553e141e33"
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

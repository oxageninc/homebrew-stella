# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.63 / @SHA_*@ placeholders below with
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
  version "0.4.63"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.63/stella-0.4.63-aarch64-apple-darwin.tar.gz"
      sha256 "fd619eea1810e331948064d48ebe1201b52dd02d51e761ddaa30c5d076474878"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.63/stella-0.4.63-x86_64-apple-darwin.tar.gz"
      sha256 "fa0b5532483ac2371efe4359618fc3bf84cb965b0f5bf5ab02bfffa87bf3f7cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.63/stella-0.4.63-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6f251453d4b9cbc30c27f6c771e00456314c78dece29222114d3cc79e102e15c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.63/stella-0.4.63-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9448101501701e8512a1864aac11d2952ed54376ffb81c3a913a3f9b8869162"
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

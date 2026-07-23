# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.84 / @SHA_*@ placeholders below with
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
  version "0.4.84"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.84/stella-0.4.84-aarch64-apple-darwin.tar.gz"
      sha256 "9a50f14195a6d384226ddb85de3df95671a052a7898bb3f5c193362185ee1b82"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.84/stella-0.4.84-x86_64-apple-darwin.tar.gz"
      sha256 "20b8b9d3fc42c8923e8c3f886037eb96c446e5c3a6b53f236e7bd482be0b80e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.84/stella-0.4.84-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "55573b17aa62618e2feef5bd76c3e4fcde2a636c749e0308134b86dad0dd84a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.84/stella-0.4.84-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28f86c66f79735e4c30f1469d0c6552ae5d5b0bce7f209674f437699602f2ce5"
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

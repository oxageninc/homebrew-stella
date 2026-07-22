# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.61 / @SHA_*@ placeholders below with
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
  version "0.4.61"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.61/stella-0.4.61-aarch64-apple-darwin.tar.gz"
      sha256 "a9d300999e3d84ae3df41def950038d1b2fbf82b5da93649dfbebd85de43c1a5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.61/stella-0.4.61-x86_64-apple-darwin.tar.gz"
      sha256 "b27f9b31586c83821edb728eae5df401fb6c4e854944f04b72603208a1a22f12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.61/stella-0.4.61-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6071528a7ea5e5dbb30bd9024361e507174494b21d4514563e9cd66de8e2ea0a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.61/stella-0.4.61-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4b0bd781a24174d0989074569fad5860a2cb1ae921e217f33b6157696e767634"
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

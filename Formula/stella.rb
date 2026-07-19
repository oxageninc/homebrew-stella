# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.33 / @SHA_*@ placeholders below with
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
  version "0.4.33"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.33/stella-0.4.33-aarch64-apple-darwin.tar.gz"
      sha256 "def6789e4e4cc878b8adda8297968e80dfe79ec94e3b0ded696de4f762e9c731"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.33/stella-0.4.33-x86_64-apple-darwin.tar.gz"
      sha256 "d315a83444fed674e3b29c4c55f46211ccc7a98758a42a71fbb5e9ad81e1a284"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.33/stella-0.4.33-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa65a8e2fba7a202914fb8aa74143db04efa1f27e6d983b9a95bcd226c304f4f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.33/stella-0.4.33-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62647e3dec50a2927167cd79202ee2a847b855e9edce484d81441f04b4842016"
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

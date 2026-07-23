# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.89 / @SHA_*@ placeholders below with
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
  version "0.4.89"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.89/stella-0.4.89-aarch64-apple-darwin.tar.gz"
      sha256 "516f436a535945c3e612c4804c29a06b2e95b903393df71e963eb0904ab31f56"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.89/stella-0.4.89-x86_64-apple-darwin.tar.gz"
      sha256 "0288654b35f47d400511d21ea194e7f941c3b79103802a21161d30a5e725e190"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.89/stella-0.4.89-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5fdcd4dfb2c5c6141852ec564dcc45a3dd6bd40c2d807fb303e30001903d9c0e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.89/stella-0.4.89-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3bae08a24d79b3597d721a44df169554ad91aa77d849c4baa3f5eadde3f106c6"
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

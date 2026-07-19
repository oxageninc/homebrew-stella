# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.30 / @SHA_*@ placeholders below with
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
  version "0.4.30"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.30/stella-0.4.30-aarch64-apple-darwin.tar.gz"
      sha256 "5e4be8740205a3ad2b9725e7673393fb9dcfb2e994b4b849183b435d1c0e0898"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.30/stella-0.4.30-x86_64-apple-darwin.tar.gz"
      sha256 "aa6a85e871e003d7f8e227b1ac28fece83d21fa98d7928d68af2b4a60e50f466"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.30/stella-0.4.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ccc97ff6e42b1f225e65293824ad87373928035c879116c98dc2e0ae6dbeba8a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.30/stella-0.4.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "92515af767adcfe199d07e18dd6b75b215ee7dd57f2b9c8fbd7804b633d5e2c4"
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

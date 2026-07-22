# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.66 / @SHA_*@ placeholders below with
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
  version "0.4.66"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.66/stella-0.4.66-aarch64-apple-darwin.tar.gz"
      sha256 "b598aa9f08a074727a20fdd67edf00598bc536949a38454c41eae24fd23515dd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.66/stella-0.4.66-x86_64-apple-darwin.tar.gz"
      sha256 "25e68abce92e96239f512b38047b5fc8ab3777a73010e41ea40da3a0d233c690"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.66/stella-0.4.66-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dea17e530d249d839d8e4f84e336028787e7b890865b6877e493a814c0af6092"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.66/stella-0.4.66-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "76fb0370aca7d1138d06467f0e21367e7b249cc54ab872bf610fe5469c3c1679"
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

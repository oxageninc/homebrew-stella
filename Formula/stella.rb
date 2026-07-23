# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.79 / @SHA_*@ placeholders below with
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
  version "0.4.79"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.79/stella-0.4.79-aarch64-apple-darwin.tar.gz"
      sha256 "8c1f7d7b7ae1f97c8a26d5fe981898b6fe872fc96a0a06a2992b671acb77e61e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.79/stella-0.4.79-x86_64-apple-darwin.tar.gz"
      sha256 "bc69b6c74106beb427c36dcca8d390787e677ebee8ff2d5cbb5123198f722562"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.79/stella-0.4.79-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a15973e9ca0416f324b83f4feaa3220e68452d0520ee00797a3315ccf2b7724b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.79/stella-0.4.79-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7188fec80a551420b91f2b9213c01042dcf64db4056c7ac10c4cd5896a787fdb"
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

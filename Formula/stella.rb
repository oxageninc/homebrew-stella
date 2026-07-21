# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.46 / @SHA_*@ placeholders below with
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
  version "0.4.46"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.46/stella-0.4.46-aarch64-apple-darwin.tar.gz"
      sha256 "3d622536cfc8446762d9896934b2108b4390a7dfd7ccee6ebabd48864bd01a96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.46/stella-0.4.46-x86_64-apple-darwin.tar.gz"
      sha256 "99ef375cb0d832e8b6544a9a1b0b415a1db87799b3402c50657a8d8a3eb84c61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.46/stella-0.4.46-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ae22a224169c3c4cf31646895f143713a3d430bc045f2699dc62d76030e31e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.46/stella-0.4.46-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2860cd22a03970619efe5702a91623dc8e40bd57448c30620e0716e77d78290"
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

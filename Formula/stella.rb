# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.6 / @SHA_*@ placeholders below with
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
  version "0.5.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.6/stella-0.5.6-aarch64-apple-darwin.tar.gz"
      sha256 "b24a258c07f14e6ec8a4911072262e88cdf5b9c03fdec47395e23936e1cb46c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.6/stella-0.5.6-x86_64-apple-darwin.tar.gz"
      sha256 "90cb6623edf13f9ce03d5486f6a3d315b113ff9c46d1b649d31f52e211401d23"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.6/stella-0.5.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa72ad32c125f61d7a8fe1fce6292d4030dab4aca6d7351beee9e8e682fbc5af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.6/stella-0.5.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d4fe7a00b4c91068eeb95575c24ba47491c7a712ac2a5d2da62949932238882"
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

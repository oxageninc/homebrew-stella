# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.15 / @SHA_*@ placeholders below with
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
  version "0.3.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.15/stella-0.3.15-aarch64-apple-darwin.tar.gz"
      sha256 "bb3453885be38aeb89c1014ff5d4030daaa45a4eea4f2b201a681e6fd919bb68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.15/stella-0.3.15-x86_64-apple-darwin.tar.gz"
      sha256 "fe13352ec49dca7a257d0b93d702c7526f1b6009f702f4dd13baec021608c56b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.15/stella-0.3.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "653c83830991ad0c7066277ee13a4c21d5963cb41c32058b77f28cd95f18465a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.15/stella-0.3.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "558e6b5f717cfa9d3d6995eefe7f598530dec2d83acea44d9affa12a477c6a20"
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

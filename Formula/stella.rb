# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.4 / @SHA_*@ placeholders below with
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
  version "0.5.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.4/stella-0.5.4-aarch64-apple-darwin.tar.gz"
      sha256 "fd3f911e06a30a0e15436ab40a689da850f6687f2c57c1abc42e66e9f1d3fbac"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.4/stella-0.5.4-x86_64-apple-darwin.tar.gz"
      sha256 "48db701b536b605f73eb37a56500891af06ba54b3076ed16a3e33da09d629975"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.4/stella-0.5.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5f1a62d262e125f37828355d8268f22319bbfe94e563ae26c6a03fd213a4946"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.4/stella-0.5.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a14c89a7c02070fb1ff301ffc3980591a72d15b749ecf607cdb39724a634fcc4"
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

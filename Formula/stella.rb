# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.82 / @SHA_*@ placeholders below with
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
  version "0.4.82"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.82/stella-0.4.82-aarch64-apple-darwin.tar.gz"
      sha256 "7cf6776a173817db02767faa3520ad816758f0e44855a2010b3f4962831448ea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.82/stella-0.4.82-x86_64-apple-darwin.tar.gz"
      sha256 "39046c81f1a8949719fceb6407fd951726b5e3034d7f9e2364323b828057f003"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.82/stella-0.4.82-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "da2ce3d5054a1ed472893558dd38436a9fb7b0fc3cd7df666ea5400d2280441d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.82/stella-0.4.82-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "66b4a965810ba578e0135b6780de04ca500f56d0236b40de9047967778b758ea"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.81 / @SHA_*@ placeholders below with
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
  version "0.4.81"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.81/stella-0.4.81-aarch64-apple-darwin.tar.gz"
      sha256 "3c424d1c5edbc912684476766d4ebd3e874d56264e380a39e44aec645c021c2d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.81/stella-0.4.81-x86_64-apple-darwin.tar.gz"
      sha256 "c38f5e85a5400392e173890874e505b74eb00d26f10ba5150db9a7993108cc96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.81/stella-0.4.81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "48bc6c328e371329ae7818db0cae4e1b271e522c1a0a167112f94f9d1a8c3a7c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.81/stella-0.4.81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9de4e82155f958c371cab3ba47fd407ff4a3ff82775cd41b97c5edf3b491ebca"
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

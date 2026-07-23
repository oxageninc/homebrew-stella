# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.76 / @SHA_*@ placeholders below with
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
  version "0.4.76"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.76/stella-0.4.76-aarch64-apple-darwin.tar.gz"
      sha256 "a5ac62599c25ea32357a519bee83870b2c2add657d8c7a725c7b8d3c3f89e897"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.76/stella-0.4.76-x86_64-apple-darwin.tar.gz"
      sha256 "35d755b1bd47a3478355abc693061b388869b43658e0804258f76faad47a3fd6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.76/stella-0.4.76-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26c0025d367682213a7f88fd72de02694846a5702073aad3d90be25250c97cc7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.76/stella-0.4.76-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5ed7d2347107e6f51d5d51bd1d3a7c5bdffae4e155e44138e28b77865a12653"
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

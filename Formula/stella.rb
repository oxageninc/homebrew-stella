# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.2 / @SHA_*@ placeholders below with
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
  version "0.5.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.2/stella-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "5a052e9acd7748952ef39adaa7991299daf1e0d4370f58ae30b7ed31c6bb34d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.2/stella-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "3eedc7400ed8bf9aa57f3e2d08edc5b4fc67169fe5c39849f84f588f685d7bb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.2/stella-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9c8c326084916267c61f1d9ab9eec98f51b227f7daf17032e23b16f0ebc1bea8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.2/stella-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d36f141f06c48990f91ff27c37e1e1ce3a007359048bac5b2aa7e983700c5d43"
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

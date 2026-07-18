# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.13 / @SHA_*@ placeholders below with
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
  version "0.3.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.13/stella-0.3.13-aarch64-apple-darwin.tar.gz"
      sha256 "e9c93488894b4d152dde76727ef0851a61c54f47c81c63c25d05a294fb15659a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.13/stella-0.3.13-x86_64-apple-darwin.tar.gz"
      sha256 "e9e7f1052bd82e2354bd2c4505d9eaf8d85b07ae806f41fc82b245f2d5ec2038"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.13/stella-0.3.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "02f545b2ea9a67ea1248ef535a3f1bcea745fbcb21f5b645bea759abd78880c1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.13/stella-0.3.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce53c634c65765611d335a9908c19f4464135eef7038de90be321921fe4c46f8"
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

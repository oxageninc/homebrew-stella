# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.62 / @SHA_*@ placeholders below with
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
  version "0.4.62"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.62/stella-0.4.62-aarch64-apple-darwin.tar.gz"
      sha256 "76ebbea3fbc420af9d95ecc106a0ae987a717de5ffce80c80343d689e0ebed56"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.62/stella-0.4.62-x86_64-apple-darwin.tar.gz"
      sha256 "23681725360b1b91e991cfbe7bbbad74f536ea350a33d910d51da8465a14d68a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.62/stella-0.4.62-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "01c687226fbaf01317ec5cfb616136ca8221d1db63aa6bc19e8d7f96aafae6d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.62/stella-0.4.62-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b142d07388fd8402bc10959cc32c7078d2f340085a0ce0b70e6ff9aff060ee7"
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

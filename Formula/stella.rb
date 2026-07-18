# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.12 / @SHA_*@ placeholders below with
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
  version "0.4.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.12/stella-0.4.12-aarch64-apple-darwin.tar.gz"
      sha256 "7b7c5d713d0e69bd68e1275a3f8a9a4a7b970101e90c16ec49eb05c1d87a0847"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.12/stella-0.4.12-x86_64-apple-darwin.tar.gz"
      sha256 "1c34bb99f7f513031762b2806e82d781cd8671880cb84f992dd0dd0cd352472a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.12/stella-0.4.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a53a4ec20d11ac3f61a03bbe9b03f037034f658285deae10d0c18ea2e6f57c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.12/stella-0.4.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "014c01d326cc2f55163be0b0397af0257bf992cf05073362d89cd4ba6b6f863c"
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

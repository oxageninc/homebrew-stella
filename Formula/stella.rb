# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.25 / @SHA_*@ placeholders below with
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
  version "0.4.25"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.25/stella-0.4.25-aarch64-apple-darwin.tar.gz"
      sha256 "bb0ca62634c0f24c146ad74fc2e0185d32eb0b56832cf6e88116b9dacd5bfb6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.25/stella-0.4.25-x86_64-apple-darwin.tar.gz"
      sha256 "d9acb0aa223e068eb95a6e3ce66d5c16f81e25e42f7f96fa27ddc698b885bf89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.25/stella-0.4.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b3533ed02bc7076e0194a40047d9638140d172cb751cba6a0db823ba4888a19"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.25/stella-0.4.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dcc01f394f21b508a8a21d4c56ead40c8461971969a97cd20fad589bf4ec654b"
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

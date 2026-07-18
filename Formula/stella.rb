# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.13 / @SHA_*@ placeholders below with
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
  version "0.4.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.13/stella-0.4.13-aarch64-apple-darwin.tar.gz"
      sha256 "0637f55ea0a2160503c0d6fa969f386f0221046bc522201f011ffcd53a5d665d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.13/stella-0.4.13-x86_64-apple-darwin.tar.gz"
      sha256 "5e6d155db690024e4bb2750b689c8e12f8f2858aebb3a5e90d33c7e7feaa34d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.13/stella-0.4.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac003f581e1486ceb0c111dfca8ec2ce2ca0d10ad275597176258238ab251a25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.13/stella-0.4.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f477f4fde0398801881f354e6367b6756caa4ab7688213fa3e52fb44638357a8"
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

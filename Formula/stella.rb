# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.35 / @SHA_*@ placeholders below with
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
  version "0.4.35"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.35/stella-0.4.35-aarch64-apple-darwin.tar.gz"
      sha256 "f7a7646e1e9edab4b62c2384c51ed25ae76ee6237ccfb8a4f2647cd3a334048b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.35/stella-0.4.35-x86_64-apple-darwin.tar.gz"
      sha256 "7bf5e9f585f95519d670189566156114a57a2a632e9f1c4feb2a0d98d343587d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.35/stella-0.4.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30dbde981a2b30b43f13cd8ed5b6919d242b60b3ac02c06c597a03a3b2f1f63b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.35/stella-0.4.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a4369a8ffc6da4c0c0f273205c9a2cbc023f6179427945f7d547d2ad2fb8aa0"
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

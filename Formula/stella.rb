# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.44 / @SHA_*@ placeholders below with
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
  version "0.4.44"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.44/stella-0.4.44-aarch64-apple-darwin.tar.gz"
      sha256 "27665cd2d227b3e1fdd84cd6c730e62ec5cc6f11fd148f0bd10beec032f64818"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.44/stella-0.4.44-x86_64-apple-darwin.tar.gz"
      sha256 "b4bcd1c1eb8107daaab70a6df3751366326b4e853f9be0b00175874c9dd3bfc3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.44/stella-0.4.44-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df85386c63a6fa276cab7a878004dc728f11c9cb7d385831a0d16756969cfba2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.44/stella-0.4.44-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e02422a25f7b40fd90f1cb104b1aa706c193a9b384c0856042e7b28ba8881243"
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

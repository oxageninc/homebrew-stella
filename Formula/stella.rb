# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.64 / @SHA_*@ placeholders below with
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
  version "0.4.64"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.64/stella-0.4.64-aarch64-apple-darwin.tar.gz"
      sha256 "84391e979239a7725b2f7f4c585549151899a6f5635f42df93d5421da84434b5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.64/stella-0.4.64-x86_64-apple-darwin.tar.gz"
      sha256 "62f02f2bf8fc7b0d97be4e95a7cfa92879106a60ee33294fcd798f211cd74b18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.64/stella-0.4.64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2bfc0ab33927fb7aa444e6489697425fb071ceb7726546a34fbf5a8499e3098c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.64/stella-0.4.64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7365c3ac5ae96f861243d9f2a8c02520ab353663cc8f9a031716d86cec79053b"
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

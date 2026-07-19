# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.32 / @SHA_*@ placeholders below with
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
  version "0.4.32"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.32/stella-0.4.32-aarch64-apple-darwin.tar.gz"
      sha256 "15b77cf35eef0041ff60c8f381c27a5875d4d867b2dee77bff9760741fe2a301"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.32/stella-0.4.32-x86_64-apple-darwin.tar.gz"
      sha256 "731af1dcaffaa343f1f693d06e42ba6bc085f9a05453e84755ed729177d533a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.32/stella-0.4.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f438609035b52c0a33e7ea658592fe92e36307566300906555f9d634b24ffdbc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.32/stella-0.4.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3fc26f532fb8182c9ed3e5f23363a2f674e7dc8274408b8d587aaafdfc349cb4"
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

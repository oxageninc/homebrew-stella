# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.51 / @SHA_*@ placeholders below with
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
  version "0.4.51"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.51/stella-0.4.51-aarch64-apple-darwin.tar.gz"
      sha256 "671aa9522718f27e1cd4b9d2b91c52d62652d50efa4fd4183d4888aaf90bfa44"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.51/stella-0.4.51-x86_64-apple-darwin.tar.gz"
      sha256 "5b8f947e62eb94bf39bde48efae41538586a5e941053f2452611deb34a8f18fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.51/stella-0.4.51-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "138f63e12900a9d70b872aa8a4e8206834ed449a270aedd66177146c9fccb5e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.51/stella-0.4.51-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5db8ceffd0d69c1b4c8ff92fe66806c23ebce9fdfd825285c8cc470a0f6bb15c"
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

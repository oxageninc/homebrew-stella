# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.19 / @SHA_*@ placeholders below with
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
  version "0.4.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.19/stella-0.4.19-aarch64-apple-darwin.tar.gz"
      sha256 "ab4fd3eb4717b7fc1237237f78524bb87c46858e1d8326c412c0316a12bbc394"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.19/stella-0.4.19-x86_64-apple-darwin.tar.gz"
      sha256 "b7e934c6b48dbe580ed0273b73c6bc0e841c4e465eea7f5f5a0655ec5d59cb60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.19/stella-0.4.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df299c2ad02b87091ddbd762e160ffbd21d45fa9bb3b7d46ef8083b8ad168025"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.19/stella-0.4.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e20320520740aa73505c40c45b080060c59273a117df44e1b41d00fa97bd016"
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

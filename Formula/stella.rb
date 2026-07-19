# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.26 / @SHA_*@ placeholders below with
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
  version "0.4.26"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.26/stella-0.4.26-aarch64-apple-darwin.tar.gz"
      sha256 "964a5463499d02266f89589d63201387051fbf695b2e1a633eecd56fdffe1cc9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.26/stella-0.4.26-x86_64-apple-darwin.tar.gz"
      sha256 "16714c4d6a0c8e53563401c21b6a192b4d5e0361a3b6b9a8f913550205ec7e16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.26/stella-0.4.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9c8bee0a37ecca1f31cce1dd271a3314dead539426da394727687a67c1be6463"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.26/stella-0.4.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b07884522d48c63fe150966c4894529b65d9303b5263e60203ded6ba6f3d273"
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

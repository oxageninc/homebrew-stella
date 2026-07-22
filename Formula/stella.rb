# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.68 / @SHA_*@ placeholders below with
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
  version "0.4.68"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.68/stella-0.4.68-aarch64-apple-darwin.tar.gz"
      sha256 "c0a3b8a702a5db59ecde549b679eb6ff25499d8260814c189084dd89b8a4d6a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.68/stella-0.4.68-x86_64-apple-darwin.tar.gz"
      sha256 "f111dfbd5daa5efea00ddcb4a3f34dc5a5019a1536e7ab84fd7401f750e1efc8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.68/stella-0.4.68-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c3ff5d21523b3acdf832cd2249e3b1881cd991e11ce94dde2ccee6a651a83ab1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.68/stella-0.4.68-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c31f3be8a223b51c05d14ab8e5ecae86e8ee6df132b5a04693154a4fa145cfb"
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

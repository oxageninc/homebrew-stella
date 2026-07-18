# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.2 / @SHA_*@ placeholders below with
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
  version "0.4.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.2/stella-0.4.2-aarch64-apple-darwin.tar.gz"
      sha256 "20fa46c3b2088e841212cf0ae40a2d13ac870e0dc5b96b5cfb9295c4a93effb0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.2/stella-0.4.2-x86_64-apple-darwin.tar.gz"
      sha256 "a6196c8660849c21e8822e9ae760a2ab8efccb34d6e8ef062dbec24afa51fd47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.2/stella-0.4.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8be18187a69717473e36f130cec9c60dd28defbb0092988356193375abc5bcb2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.2/stella-0.4.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e8785f97031764232a08f9e0acdeb8b876c8135193c5bee23028eb0c75273b02"
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

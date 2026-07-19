# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.31 / @SHA_*@ placeholders below with
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
  version "0.4.31"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.31/stella-0.4.31-aarch64-apple-darwin.tar.gz"
      sha256 "2b91c748b3a8cd89f3aeb712f95c766424301a236efacfc503a810ccec8984a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.31/stella-0.4.31-x86_64-apple-darwin.tar.gz"
      sha256 "ae8a9f5dd67a3d684008f42cd06265d4de6ba9a545865404b1e4bd1f739e2af7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.31/stella-0.4.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "65f5e4f4cc94dd96ae7597c46ae7e327912c1259c440f4023f1aa3b0b386ca75"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.31/stella-0.4.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "229863ef4aa1eeae335156042ec1ff340c8fedcd5d76244d54ce49050ca49a32"
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

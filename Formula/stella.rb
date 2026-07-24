# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.3 / @SHA_*@ placeholders below with
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
  version "0.5.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.3/stella-0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "f692b3cdef4195b0aff487a1814775da6c101d1d97bc516788fdd0595f4f0c18"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.3/stella-0.5.3-x86_64-apple-darwin.tar.gz"
      sha256 "af2abd7d4f50153b4bb17bc33bedc30ae575faab3151a9a1d9572cf471fb1f8e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.3/stella-0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b9ab292952958f2826984e56e290139d000d8628d3e1c5e63b7d67dae40536a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.3/stella-0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6bb3be0b912ba55c9f963b300b7ccdda76955b02ce3cfdb9bc175ba6e933cbc9"
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

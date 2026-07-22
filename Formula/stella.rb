# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.60 / @SHA_*@ placeholders below with
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
  version "0.4.60"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.60/stella-0.4.60-aarch64-apple-darwin.tar.gz"
      sha256 "78cf833887787d5da94a5889ed171e9a4b867a4ee4d15f0e110737bc073fc0a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.60/stella-0.4.60-x86_64-apple-darwin.tar.gz"
      sha256 "e9638f49b3b8200a1a8ed2b51da40769504b880a8a4b43c8f2d0a17ba6aff98c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.60/stella-0.4.60-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b6867e4138f8aae29c16eccc28eefe06e4a1f7dab187aa2e2d90759a75298d9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.60/stella-0.4.60-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31fd6413fa9cfe92474dbc5fc7cefa6ce53c2c068f90065d69d6f42a6fd4200c"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.55 / @SHA_*@ placeholders below with
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
  version "0.4.55"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.55/stella-0.4.55-aarch64-apple-darwin.tar.gz"
      sha256 "c367e0d426e8a975838da9d685c09217ade1b010ec68d33721757af5a9ea2829"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.55/stella-0.4.55-x86_64-apple-darwin.tar.gz"
      sha256 "4c7f5d9c9601b04b6f67b744abdd893afddbfe24fc0d50cce708361e996db378"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.55/stella-0.4.55-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ba433a689eed9f4ef0afff4843e2a3430e33237409b84f76dc5412c52cd28d0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.55/stella-0.4.55-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "13f6900e0c8da18c3d09db25fa53c67c6d222a041580a26633d0a98ef71772ef"
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

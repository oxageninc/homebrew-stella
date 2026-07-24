# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.7 / @SHA_*@ placeholders below with
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
  version "0.5.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.7/stella-0.5.7-aarch64-apple-darwin.tar.gz"
      sha256 "58d22678607bf088037807b133ceb735b47611f77d07714c313546a6f5f30f00"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.7/stella-0.5.7-x86_64-apple-darwin.tar.gz"
      sha256 "2244eac1750beae6fe32011b192fca7e7dec3cd31329be411b82d30e322a59b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.7/stella-0.5.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47b8fa01611ce9cf30eb87263105babd9fc5aaed46e481f330cf30fa65cfb5fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.7/stella-0.5.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "682fe922b28c8f288fb2529d00d86f29058bac06c48cd05fff4a95d54cfa856c"
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

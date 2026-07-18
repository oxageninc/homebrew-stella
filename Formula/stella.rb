# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.20 / @SHA_*@ placeholders below with
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
  version "0.3.20"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.20/stella-0.3.20-aarch64-apple-darwin.tar.gz"
      sha256 "8735d645ffeecff525cdec13b4c455f1c4caab38159e1c1a5d9c25f81e720fb2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.20/stella-0.3.20-x86_64-apple-darwin.tar.gz"
      sha256 "774f09e38842eed6a39f0fbe99ecee749275fdf37886788e8a38834fa3cf95b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.20/stella-0.3.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aae94c3594b3be0ae1b667979c6c1b0fd4d3c024ddd1f6aaa0ab965a2957d570"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.20/stella-0.3.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c49e7c57b67325af8e6ba535568d1951b5208eb276ce11899c35ccd4d1b90799"
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

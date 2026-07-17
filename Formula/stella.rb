# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.10 / @SHA_*@ placeholders below with
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
  version "0.3.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.10/stella-0.3.10-aarch64-apple-darwin.tar.gz"
      sha256 "42091b92411b3adda6308b3609dee5c2580b4927b4dab0ba0af2b9c4bc96b36b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.10/stella-0.3.10-x86_64-apple-darwin.tar.gz"
      sha256 "0e3ff2c3d0fa3175b4b379af6a87af692a5727b04472c09aad422ed7076760af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.10/stella-0.3.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b379e76a2d9f55396799ff9719e26ab3c43dfea064991fef2acd05da5268e015"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.10/stella-0.3.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a2058513ad473a408cc4062544f443a9707ec680a4824820db697a3e72b6d905"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.8 / @SHA_*@ placeholders below with
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
  version "0.3.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.8/stella-0.3.8-aarch64-apple-darwin.tar.gz"
      sha256 "b2c15c67d29c13fd506c31aa0be56aaa5281443535b81290942144af1e90e9e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.8/stella-0.3.8-x86_64-apple-darwin.tar.gz"
      sha256 "91455c7b6860fe156261bf9656e84a3c5df271e9bdefb830099faf615b3028d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.8/stella-0.3.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a82545128bb2b645ae00fa419070bab9e78b7eecb9ab767a561a7c11454c23fc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.8/stella-0.3.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e55aa04643384690ff3f448ba2ca01ec1a09af85bafe894affaebddbf7f4fd31"
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

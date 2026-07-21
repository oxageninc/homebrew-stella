# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.52 / @SHA_*@ placeholders below with
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
  version "0.4.52"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.52/stella-0.4.52-aarch64-apple-darwin.tar.gz"
      sha256 "d2ff58b857470e2cdb6bce681b2c075a4d3964202f691fc5f7095d170899d28d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.52/stella-0.4.52-x86_64-apple-darwin.tar.gz"
      sha256 "429a7a87387808a29dba1f50572d8682fcbf8fbfd1d8d3592f34fa2a3cd06d72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.52/stella-0.4.52-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "babc59d37c3aa4439452a1e24a2c8495196ae98311fb9654c44528d370c76ff2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.52/stella-0.4.52-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "784a70033fca2723661a192114e782eb35be46aee6176c6834ed3906693f0fad"
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

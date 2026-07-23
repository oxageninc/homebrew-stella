# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.75 / @SHA_*@ placeholders below with
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
  version "0.4.75"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.75/stella-0.4.75-aarch64-apple-darwin.tar.gz"
      sha256 "ee548851f34be38e30dd93ddafe86744ee785339c421e85c652c86cdfb952314"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.75/stella-0.4.75-x86_64-apple-darwin.tar.gz"
      sha256 "22d0a71ef998caa97bfebf70188c22c749cc81c8082ec0756f3238ce29448f48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.75/stella-0.4.75-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cff40581dd81e774ff4270c5836b9a4ffe725c290ca9a8f20e106f792d4bb53"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.75/stella-0.4.75-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42b999dc15afd99c0e897753d4856023fca3f2cf58dbfa5f1d8de4c6b94edc2c"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.9 / @SHA_*@ placeholders below with
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
  version "0.3.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.9/stella-0.3.9-aarch64-apple-darwin.tar.gz"
      sha256 "c27dff79364e30f4e5c6584f0df9a9d5cb39ed314de95ce652a9d43f800467b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.9/stella-0.3.9-x86_64-apple-darwin.tar.gz"
      sha256 "bc618f8475025f0b463a55cc396f347cb6711f43bb2c9a23783c67f56d02135a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.9/stella-0.3.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "99d463792c5e10a36dd9129adc38d21235cdd6f0e7ca902a9414130b757b476c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.9/stella-0.3.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a536c8833dc42e173b1cbb35a4210cafdbc59bcec2ab1c612347acd3ed09269"
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

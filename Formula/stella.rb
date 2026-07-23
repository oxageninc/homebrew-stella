# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.86 / @SHA_*@ placeholders below with
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
  version "0.4.86"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.86/stella-0.4.86-aarch64-apple-darwin.tar.gz"
      sha256 "3aa25956d565b80dac33cd52b058eb3d9b158c33a8295e792dfa351579ea0fbf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.86/stella-0.4.86-x86_64-apple-darwin.tar.gz"
      sha256 "b06036b1fcbe1ebfe9dee5816dce3a6fce7d662707399e832c82af641c22981b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.86/stella-0.4.86-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "faa99e02ec5d8f1864e2715c788c6313e730a9281709a179728d156f46144986"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.86/stella-0.4.86-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "332a2a36376bfb75237cc1803a40b9f34556706df0b47ad67fbff428c5ee8dfd"
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

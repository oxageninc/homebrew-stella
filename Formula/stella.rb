# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.90 / @SHA_*@ placeholders below with
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
  version "0.4.90"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.90/stella-0.4.90-aarch64-apple-darwin.tar.gz"
      sha256 "fa85a499c1158d753db93c059e48b248b67924dbb9a831e3f64179def9d1dc36"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.90/stella-0.4.90-x86_64-apple-darwin.tar.gz"
      sha256 "8e1d2a18a935c3a1509200a6019af787db5856171821e802d7682406df0de7fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.90/stella-0.4.90-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "863c1060f4d74c46b830798310129429de19cdae61b53a56d6bfcaa79893d023"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.90/stella-0.4.90-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a9ff4f50546e80c6065e21cd97b4e5dae8cfea320cdba4482f225eae1251ca4"
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

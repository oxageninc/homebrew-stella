# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.12 / @SHA_*@ placeholders below with
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
  version "0.3.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.12/stella-0.3.12-aarch64-apple-darwin.tar.gz"
      sha256 "b226911071574b85dfd525b7bd88bd7e2b6236002e8852f4036758ddb2f85227"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.12/stella-0.3.12-x86_64-apple-darwin.tar.gz"
      sha256 "33b8c272ee6ee66e223a30a5522c16b77e6a413205f667e944bb687fb3a8c187"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.12/stella-0.3.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bcdcf481eb6f55a4b732e2f6178cb06c591a6d229f247863e93c85e959220c8c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.12/stella-0.3.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "934c6b569c46d612b10deb1954b30affb25210848bf11c45693014c23bcd92c1"
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

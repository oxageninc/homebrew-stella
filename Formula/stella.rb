# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.24 / @SHA_*@ placeholders below with
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
  version "0.4.24"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.24/stella-0.4.24-aarch64-apple-darwin.tar.gz"
      sha256 "ae2e5e2f5e9b5932267f2bff909441696fb7b27e62423761504c8efae415cffd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.24/stella-0.4.24-x86_64-apple-darwin.tar.gz"
      sha256 "10294ff4da9cef2bf18d7d30f43e2e2835e49a87b3018dce35a5d49fd4417a17"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.24/stella-0.4.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "db12000f8b5b3f7de0f4ddabab0ac203aafb5dfff6997e53cbb0f290e0d141e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.24/stella-0.4.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cac54bfa1376b1e16f973f6c706c8e96a5b68555679977553c93093ef05b31f1"
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

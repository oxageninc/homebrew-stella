# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.4 / @SHA_*@ placeholders below with
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
  version "0.3.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.4/stella-0.3.4-aarch64-apple-darwin.tar.gz"
      sha256 "97e7809cb8287e4c8d7080fd9c0d9ed7900a048600d2109077788f50a5d053a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.4/stella-0.3.4-x86_64-apple-darwin.tar.gz"
      sha256 "56196dbd19592b670bdcd9324c8b43f7c74d46fd4ee18396f4d77052375a58f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.4/stella-0.3.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c03b39007a86a6f8e93cfdc9a38a2d0fb1210e72679aeec96cc483e291dcc8a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.4/stella-0.3.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "918e03bb0f26a9e4f16a488d9ddfbd9bc02168b8c27e390d5049d4ed8c07e86b"
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

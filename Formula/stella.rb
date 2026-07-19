# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.42 / @SHA_*@ placeholders below with
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
  version "0.4.42"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.42/stella-0.4.42-aarch64-apple-darwin.tar.gz"
      sha256 "0d025189d92c89b29a3d182c07fdd7f751c68f26251ebdc6ce968437a81d22f3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.42/stella-0.4.42-x86_64-apple-darwin.tar.gz"
      sha256 "0a200e1ba82b82faf235ad82b2c9e0d6d1de381ed474c71f49601cdc817947b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.42/stella-0.4.42-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "323d93efde035c7546c962e9631a67406d3c9d033692af05be2e4785b27e4c6d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.42/stella-0.4.42-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "be6ba24a82636c49ae7fc2f6901ca8c1ed718d55f67b40791edba8738d42c458"
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

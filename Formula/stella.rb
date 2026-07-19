# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.39 / @SHA_*@ placeholders below with
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
  version "0.4.39"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.39/stella-0.4.39-aarch64-apple-darwin.tar.gz"
      sha256 "934495bfc5ab3cbd6a670f26548da0696f407bb1283e556047c455befaac82d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.39/stella-0.4.39-x86_64-apple-darwin.tar.gz"
      sha256 "c5cf64d79ec78fcd15b1f9b751102e843672b1318fdf200b3d5b371dd425d570"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.39/stella-0.4.39-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9daf2f0725b84bd32623fb671d95219869392ddd047dfa0e1a969dfd95010059"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.39/stella-0.4.39-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb4b83e73241d1931d0375836a0cf1f8c512b0c4bcdf0b09a05885db534b5a70"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.74 / @SHA_*@ placeholders below with
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
  version "0.4.74"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.74/stella-0.4.74-aarch64-apple-darwin.tar.gz"
      sha256 "876bd604b71bfa325f5739373b476305edd4cda5f8687b18fe1fc4ed4f9df9f5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.74/stella-0.4.74-x86_64-apple-darwin.tar.gz"
      sha256 "1d061cc92fe0786f1dfd162e186ca7d4f9d486e0a4d870236c785a90ddd974ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.74/stella-0.4.74-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24ee3fef477d62e08a3be7a2d2f65282a0b5cc173bde03b1d42e8318eee991d3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.74/stella-0.4.74-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "526b175d7499e00c916ba39cc21db3161dc0e3975b46dc4a5eba31886f79550f"
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

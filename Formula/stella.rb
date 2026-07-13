# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.1.17 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (oxageninc/homebrew-stella) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/oxageninc/stella"
  version "0.1.17"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.17/stella-0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "ed5e225187ac961843d46cddb16a590a5a35c84303267c66cd98c7a47abf1284"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.17/stella-0.1.17-x86_64-apple-darwin.tar.gz"
      sha256 "53a8e86c735b04793d99d60557cbb2c2e5783b0e53869ec86b5f211eb4fc9b21"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.17/stella-0.1.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "27a532253d16c32df012d17a3e5e30e031b7f4fe4ac4cf78885c4b8cf1de11e1"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.1.17/stella-0.1.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3807af313e2e8159443374d5ace20cff0d16d92a7db10442b5fd5fdd99190b8c"
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

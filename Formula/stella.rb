# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.45 / @SHA_*@ placeholders below with
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
  version "0.4.45"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.45/stella-0.4.45-aarch64-apple-darwin.tar.gz"
      sha256 "40d7dc14669ed24d9f45d79a88e0cd5f158ce240c5c5f2f351f4eda113737dd7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.45/stella-0.4.45-x86_64-apple-darwin.tar.gz"
      sha256 "da7dd8908ebea2bc813bdd1b546adc8af2fb9d9e8f47652601a128fa4b877739"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.45/stella-0.4.45-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "677c4ee04fe78e7739b88f55662aa5982d04fb4cecd0f9017e62a3010e05d201"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.45/stella-0.4.45-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9702bdd1c87e54171c1217d43a7c2c4d5e338e64848e93d7ee1ad5348f97ee74"
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

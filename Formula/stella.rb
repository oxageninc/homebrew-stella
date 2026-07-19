# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.41 / @SHA_*@ placeholders below with
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
  version "0.4.41"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.41/stella-0.4.41-aarch64-apple-darwin.tar.gz"
      sha256 "3323faee62ae9aa678291aac387019b0c465838557b2005d47ef1656ce57fdc4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.41/stella-0.4.41-x86_64-apple-darwin.tar.gz"
      sha256 "ae2dbd3e673f8472dc44fe13ec8e8ebe0622ba6b9a04f5e797b739f0e9348020"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.41/stella-0.4.41-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df04aee6953b6e52a5813c28babb087564df0a753a086079fa8b1e06cbc2ba45"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.41/stella-0.4.41-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3426f7a09db7290bc2f929b4e0a15f1147a4b03c584a77007fc50d1d32c8139"
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

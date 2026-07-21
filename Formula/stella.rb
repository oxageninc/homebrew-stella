# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.57 / @SHA_*@ placeholders below with
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
  version "0.4.57"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.57/stella-0.4.57-aarch64-apple-darwin.tar.gz"
      sha256 "33ce5082fc9107dc3b031cdf1cbc376889055238dc47c988fd281b149da235f7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.57/stella-0.4.57-x86_64-apple-darwin.tar.gz"
      sha256 "60cf5f8f50bb1619035da532b68d156a6edac66c3df36752190bfdfa4ec172ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.57/stella-0.4.57-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7f7a0f23d6bc49f4d8ae0a3e5c933344e3586b346a3de35a56d6a30f67b57982"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.57/stella-0.4.57-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2aa40a30126bf2051458695da1c105ed8583c4e1b2e7da50d0df954979a8ce9c"
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

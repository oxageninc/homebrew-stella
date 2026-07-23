# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.88 / @SHA_*@ placeholders below with
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
  version "0.4.88"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.88/stella-0.4.88-aarch64-apple-darwin.tar.gz"
      sha256 "d80ec0e0f7ef08a6848c87ba3a70899ba2e388c6806be66043d2046e58334311"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.88/stella-0.4.88-x86_64-apple-darwin.tar.gz"
      sha256 "68e70a2dc3367f63999427cbb95c1ddf27ded6b2d76fd5388fe42177fdb041a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.88/stella-0.4.88-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "62781d0f691d4645a57c493bb52788dcfe69477833406a18b475bf6301139875"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.88/stella-0.4.88-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "655ab5a19e2eee9637aa8c1a0262255065be9a2d203d62f9b44e13e909111956"
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

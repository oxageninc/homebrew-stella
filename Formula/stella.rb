# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.80 / @SHA_*@ placeholders below with
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
  version "0.4.80"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.80/stella-0.4.80-aarch64-apple-darwin.tar.gz"
      sha256 "011ef55a4f99cb489fb571f96b88daa9ec8059429c955847347a038b3149d271"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.80/stella-0.4.80-x86_64-apple-darwin.tar.gz"
      sha256 "2f92d8be7477851569aaea64bdc280ae16d8f9fc9f6470162dca428aa9f2947f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.80/stella-0.4.80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39fde75bf5fb3585998258750ec96e84c4e0a071427e1168efa17326a7d0cc74"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.80/stella-0.4.80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b329b7bc63716259f439376cec2a02d25c6c382374ae2640bb72e5f4d8ce6a76"
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

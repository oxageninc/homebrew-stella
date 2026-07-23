# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.92 / @SHA_*@ placeholders below with
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
  version "0.4.92"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.92/stella-0.4.92-aarch64-apple-darwin.tar.gz"
      sha256 "b55bcd7a08a9ad729320d3415e92933b1292d3520df8dd3e8589fd463e56e97b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.92/stella-0.4.92-x86_64-apple-darwin.tar.gz"
      sha256 "c82aa8a8e18061726a1779e69c318690193b6dc6886d6b13cb1bb31632afc93c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.92/stella-0.4.92-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a9798c9ad5e0a254c138325449a8b4c3bacb536699f3c2d2ea37b438b8f7f613"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.92/stella-0.4.92-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0f6991206427e7ed43d6efbbda6f63866bf1a283b57d2ceac8ec99aefc5dc70"
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

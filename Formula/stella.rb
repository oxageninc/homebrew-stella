# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.11 / @SHA_*@ placeholders below with
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
  version "0.3.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.11/stella-0.3.11-aarch64-apple-darwin.tar.gz"
      sha256 "da30c106b4e33b95326bf3ff164b79dbc297b227e68b16f4bb3a862c55212201"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.11/stella-0.3.11-x86_64-apple-darwin.tar.gz"
      sha256 "861e7ffaf62271a1d38c2dd161e4fd63344afeda478337b3b3f34f9d3b393209"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.11/stella-0.3.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d140a86c2a10484a3f099f75efa00380b763087b25bdc5644d9edfa2303e08a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.11/stella-0.3.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8812fee9a8087ef037837e941e180fe932fa68d1ac6e8c5abcf2bce89966132b"
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

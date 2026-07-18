# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.17 / @SHA_*@ placeholders below with
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
  version "0.3.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.17/stella-0.3.17-aarch64-apple-darwin.tar.gz"
      sha256 "2573ebf06024ac894f28b3661f65a0f51dc59d5376f51d3c09db7e36fb081c0d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.17/stella-0.3.17-x86_64-apple-darwin.tar.gz"
      sha256 "e50796729df5a3e2c93e433eebe9d88e85f901909f181a1f5dc1cc2f3fb50b27"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.17/stella-0.3.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d378615b8244bd51a35a9f2d0d805de3c45cd8acc4b4b7b8ab056594d992e33"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.17/stella-0.3.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a665315d3d6a94f515ebbe8e2fb43a83cd8033a15bc182bce9798ff7e2dc3b6"
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

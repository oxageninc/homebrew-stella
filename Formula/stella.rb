# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.20 / @SHA_*@ placeholders below with
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
  version "0.4.20"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.20/stella-0.4.20-aarch64-apple-darwin.tar.gz"
      sha256 "1ae706ddf66137bbecda8463864f7b6f351ee60b54d12da0e442c981b4d6bc21"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.20/stella-0.4.20-x86_64-apple-darwin.tar.gz"
      sha256 "f0b8f18a6cde8627d74c686c5ee86cefc015317307b2d67e0881545b1abe0dc3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.20/stella-0.4.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8594ffc63eabc71207f9668cf861dd68c9078d7136d4c09d03136bf070ff56c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.20/stella-0.4.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bec107bda9ccf2f1226954c9b51e82d5fc5ed29bbfc0a610407eaad47286ce97"
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

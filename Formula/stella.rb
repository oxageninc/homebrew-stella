# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.22 / @SHA_*@ placeholders below with
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
  version "0.4.22"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.22/stella-0.4.22-aarch64-apple-darwin.tar.gz"
      sha256 "9c6eab62358dd9fe52bf7528ebd1537a39badd8d2290da57d1379412ae4ff9f0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.22/stella-0.4.22-x86_64-apple-darwin.tar.gz"
      sha256 "7a220a0827f02b9be6c2f675e87b91ca934b381a99ff78d69b6336761b7af3dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.22/stella-0.4.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "341a202189687f54bff25eae0aa2ebba70921f30cb10d6fbdcb19475d6960638"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.22/stella-0.4.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f1a2d2768ce724cf8991516c19c662f4a3c0190405ba4b73d184c3ae36f04dd"
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

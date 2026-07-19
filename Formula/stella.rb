# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.37 / @SHA_*@ placeholders below with
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
  version "0.4.37"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.37/stella-0.4.37-aarch64-apple-darwin.tar.gz"
      sha256 "57f1b102050f996eeaebaa9dafb656a7a8398611337fbd64f65f3bbf75abba45"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.37/stella-0.4.37-x86_64-apple-darwin.tar.gz"
      sha256 "687fef75885d27ce90f763df048db1ab645666c4425aae1c514736dc1f6f1c6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.37/stella-0.4.37-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e192f67fecc504c03493a943e882eb36f7d0de5c44af3d2400d0d2b701c2b809"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.37/stella-0.4.37-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e3c935b4738ad2cb931171ccf6d9d5ad79c289719c8bd85e7255ab657749bbb3"
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

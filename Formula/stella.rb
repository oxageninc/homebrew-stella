# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.43 / @SHA_*@ placeholders below with
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
  version "0.4.43"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.43/stella-0.4.43-aarch64-apple-darwin.tar.gz"
      sha256 "9fd12187f7e085acfdcf9ad50b323048b27f95865d125b8a9193436a0ff10336"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.43/stella-0.4.43-x86_64-apple-darwin.tar.gz"
      sha256 "1d2f2ee7f85ce554c2e1544a3a3dae69d572ba4b9ccdef8616c2c2ebdb2752f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.43/stella-0.4.43-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "21ed88855be6f59a9e53dcd3ec304eee298d18e72a5bb4e014c9ddcbad6d76cb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.43/stella-0.4.43-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4253899960d6393bda0a54e6add292cea0d4167d321917be66c5db9e6718225"
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

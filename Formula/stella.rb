# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.87 / @SHA_*@ placeholders below with
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
  version "0.4.87"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.87/stella-0.4.87-aarch64-apple-darwin.tar.gz"
      sha256 "b7e484d110d7807f4a7d19d80b48143e12b106ef1e41bf615c51f1dfadd06612"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.87/stella-0.4.87-x86_64-apple-darwin.tar.gz"
      sha256 "fdf7cfeb16551cfe6fbbbf570ce355178f857ea0a11cc323bf2e9155946e7458"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.87/stella-0.4.87-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b661c5899a51910c6e2d89ff0386bbb4ab1020b2759b2ebe248afdb1ad889210"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.87/stella-0.4.87-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "de390205f62e77f191f7d8f941f3037f39d605b740700f5d2888c5d00af5b1ab"
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

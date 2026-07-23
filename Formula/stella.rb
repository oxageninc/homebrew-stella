# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.71 / @SHA_*@ placeholders below with
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
  version "0.4.71"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.71/stella-0.4.71-aarch64-apple-darwin.tar.gz"
      sha256 "70650160a63e925aa7fc94906419fddb2074bee2a0a37eb64a3d4f9d4eb7af05"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.71/stella-0.4.71-x86_64-apple-darwin.tar.gz"
      sha256 "eb82f1926a95709ef336c6deed2ac380bf2d6c96cb490651594d9bb32e25c7d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.71/stella-0.4.71-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dba64c51f257d3d1efad752b1d9fb96726b38576c1d4d75af1ab2c5f691dc850"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.71/stella-0.4.71-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4b9899a43c6cdd298e13591ee84fbfa741327c3f087f59bfb9745df2645540aa"
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

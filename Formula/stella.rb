# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.91 / @SHA_*@ placeholders below with
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
  version "0.4.91"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.91/stella-0.4.91-aarch64-apple-darwin.tar.gz"
      sha256 "1132483b66eed001881770886802c73c8cca74118360978e884127353fc69da0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.91/stella-0.4.91-x86_64-apple-darwin.tar.gz"
      sha256 "a9f40df9a708f45c08df9ba75d3bf539f6e511c52fe256d81d03df25a9aa835d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.91/stella-0.4.91-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cfa985bd5be615830e8cc751ac8bf6b240d7f3a28090fae2b630d5880f1c8feb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.91/stella-0.4.91-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b545eff85feace967985b948f8e00c22cfcb11edbd353ccbdbc8ef632f4011f8"
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

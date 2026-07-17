# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.5 / @SHA_*@ placeholders below with
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
  version "0.3.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.5/stella-0.3.5-aarch64-apple-darwin.tar.gz"
      sha256 "c7961ddfba1fec09b3bec5408e3f721d265d0c29a434c012749d13e0dca76c57"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.5/stella-0.3.5-x86_64-apple-darwin.tar.gz"
      sha256 "7a0d8be02d29393d31e4780709a6ecf38736fcce37afb4cad8c002424eb8db12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.5/stella-0.3.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "15a903335f951fbab9ce317ce555a915708b2891048e04e4928a0c679d6afabf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.5/stella-0.3.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e88f27ad3691e8dc951bbd3699c24690e67a3837f54079227501c8964dbc048"
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

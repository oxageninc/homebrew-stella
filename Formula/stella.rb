# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.56 / @SHA_*@ placeholders below with
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
  version "0.4.56"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.56/stella-0.4.56-aarch64-apple-darwin.tar.gz"
      sha256 "7c65bf94ed76699b1d567d71b13205c9f3881051d5fd6740ea9a12f797c8cc40"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.56/stella-0.4.56-x86_64-apple-darwin.tar.gz"
      sha256 "f5a4d4ee5cabe08ed1b202361b16701961dcde0bd31d824a6223317e28493a27"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.56/stella-0.4.56-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "595c8ad7bee827ddecb0d67bbefa3e9aa78203955193209ebd977e7855e9b7ec"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.56/stella-0.4.56-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ceff944c28cbdee07c9b657b9f96a7fb3e3bb227127f82470e7c42f207d547d9"
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

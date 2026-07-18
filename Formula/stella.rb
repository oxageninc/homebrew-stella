# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.14 / @SHA_*@ placeholders below with
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
  version "0.3.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.14/stella-0.3.14-aarch64-apple-darwin.tar.gz"
      sha256 "f3be9c2ae67481ca47461c2fe1e89f9457d89021d9dad02aa1500e7fd5a6288c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.14/stella-0.3.14-x86_64-apple-darwin.tar.gz"
      sha256 "00de27eae2c06fb28f5c5bcce879d6233df963604c0d52aac5e3dbb1f4972aff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.14/stella-0.3.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e860a0f71b648e43c8cef2749bb883e234766a2393d9f0ff7a718a06d8fbfd3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.14/stella-0.3.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0319e8040da505729415181d5869b59495fe67edbf281168c99e33913b482ff9"
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

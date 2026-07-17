# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.0 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-stella) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.0/stella-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "297fde0d08219b365057aa12b894a8e628f5ca3cb6e9bdbee47e642ec58b8181"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.0/stella-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "2a3ca31d46e966cd3fa9db4fa78b75e832f340c7e21baaf614eef74163c5794c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.0/stella-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "574ed34749e8eec131ef26b4d82d791a62d1773c774f2830279a731a244a4603"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.0/stella-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eaea655e1f590a4fc8f1435d43420e3a0b49a9ba0698714fca3b0b5c3cf6c7fe"
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

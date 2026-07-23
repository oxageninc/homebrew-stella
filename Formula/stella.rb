# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.77 / @SHA_*@ placeholders below with
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
  version "0.4.77"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.77/stella-0.4.77-aarch64-apple-darwin.tar.gz"
      sha256 "ae55ed3e9be529f3a80a93cf04021a1b174cb9536c57c6c148bbc3d19df64dce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.77/stella-0.4.77-x86_64-apple-darwin.tar.gz"
      sha256 "40c10ea3a369f795e54ca692439efba1bea18632d90dcffae3f9fda55e2f4525"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.77/stella-0.4.77-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "75b223450a37ca0abb710d8457cd1d5158264ad7b74cccfca52294d59980178b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.77/stella-0.4.77-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1df6a69dae03e988456f839cb146bd0eef4857fe274765436741985d308e967"
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

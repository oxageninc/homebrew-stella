# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.48 / @SHA_*@ placeholders below with
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
  version "0.4.48"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.48/stella-0.4.48-aarch64-apple-darwin.tar.gz"
      sha256 "10d9566474f2a1db5a67a7d3b83612276bc8ef212d5b5bdb715a2acfc93d4365"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.48/stella-0.4.48-x86_64-apple-darwin.tar.gz"
      sha256 "dab4bb0708fb546968bbe5de8c1ad420a1ec24620ce21ec09b9847109c66bbdd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.48/stella-0.4.48-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e46f144374d1b36f6a227b3da52f6aa2a2be98a441ab5bc24478c4aa46af026"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.48/stella-0.4.48-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31900c788e565a7254d25bc83b5a4c0f705b18d7e3f339982ef8ea7eb5911f8a"
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

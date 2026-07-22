# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.70 / @SHA_*@ placeholders below with
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
  version "0.4.70"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.70/stella-0.4.70-aarch64-apple-darwin.tar.gz"
      sha256 "42edddf87d419c7c14f1dcdc2c7a7639e7b7c9979ce72700cd22c4be3bbd94e1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.70/stella-0.4.70-x86_64-apple-darwin.tar.gz"
      sha256 "8423ee5a50f77648398c6c0fb326e7212a6fbd8ad38e82b50c966120d4011d6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.70/stella-0.4.70-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3936c1d6a1419cea9d4eb1815ffa265dd80d18bb65112a6fd21818edf3d40c3e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.70/stella-0.4.70-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "150471d801183f5ac733cf68a798997c9990b41badc3fe385650f2bd99e6e990"
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

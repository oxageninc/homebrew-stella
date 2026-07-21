# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.50 / @SHA_*@ placeholders below with
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
  version "0.4.50"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.50/stella-0.4.50-aarch64-apple-darwin.tar.gz"
      sha256 "d8b1f280280e670bb92133f99f7f762bc543bbe39d86c69d70a40065abd3d521"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.50/stella-0.4.50-x86_64-apple-darwin.tar.gz"
      sha256 "d311910594cb51068329d2bd06150623d8f33548a285322dd921ebfa8f9a4926"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.50/stella-0.4.50-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd8a666213b068c1f421a2cc80c9f43ab43cb0678b1156faebe49772bcf6ed68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.50/stella-0.4.50-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7087b8006f32e0f6f2e1e3f2dc14d19278a8e41a493710cb3a58846442c5dd48"
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

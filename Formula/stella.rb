# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.54 / @SHA_*@ placeholders below with
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
  version "0.4.54"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.54/stella-0.4.54-aarch64-apple-darwin.tar.gz"
      sha256 "d537b05840fc7e9ff1bfc7f52e7e0c0f5484b61d363745919489b5e9a14d5c46"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.54/stella-0.4.54-x86_64-apple-darwin.tar.gz"
      sha256 "c1e4d83db1b9922e5d168f6e4ee094bb3a4d63af5658565984188d4c8e694551"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.54/stella-0.4.54-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d9a369b359ea98fa40168c99916deab65a06a83ac1635aee151dd4690581bd43"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.54/stella-0.4.54-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49c1118b2b264cb47def19787765f11bb127ad8de88b237f418da068b945424c"
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

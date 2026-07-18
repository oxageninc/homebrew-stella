# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.1 / @SHA_*@ placeholders below with
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
  version "0.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.1/stella-0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "76e39e13006e16aa0de097a3e70207be8625bd27a8c20c215cfde841fcee0501"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.1/stella-0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "b6a3a752a745f6196bd8e2e3a91e859795fb15504598a6f9b99f32f0e3b5269c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.1/stella-0.4.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22e7d00b128bafe0f68f513e27dc5d88db88fd19539d855b9c4ad7136889b24b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.1/stella-0.4.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc3670a32330b1443d8a421b1c42fc733b4ed8518acf1ee0feebf1ae7e759513"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.10 / @SHA_*@ placeholders below with
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
  version "0.4.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.10/stella-0.4.10-aarch64-apple-darwin.tar.gz"
      sha256 "2871f5da8ed57e9693bffc5a760e772ba4e6536c130d268207bc6635a450098f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.10/stella-0.4.10-x86_64-apple-darwin.tar.gz"
      sha256 "b9331d7d094acedf47226c1ff2885febb698302df949d0e64b5757383d138fe1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.10/stella-0.4.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "48529b233d9819945a3c6a79a0e59dd2f174fb5b3b5de6f30cc1b59c3c3da941"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.10/stella-0.4.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68cc1d7bbc42f4223c0a0f1be831adca5fc5597c259b4f62dda5c9396d8c2ade"
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

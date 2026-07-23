# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.78 / @SHA_*@ placeholders below with
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
  version "0.4.78"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.78/stella-0.4.78-aarch64-apple-darwin.tar.gz"
      sha256 "60f2b12fd1f4af426dcf0920d6e0f18208647e5bed23acc955f34aa613d848e7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.78/stella-0.4.78-x86_64-apple-darwin.tar.gz"
      sha256 "b1a4f0e18ea3fac3b8288ed99203aa107144d3fbd0d4bed1dded92f57baf1f3a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.78/stella-0.4.78-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eaee1be0266db6ea0e62e00c9954e312081655ec24eeba371e12b70dbba596d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.78/stella-0.4.78-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "937495a6859aee0331c4e253f11233bcdd00b48bea04718f324b1b1f8c7a2c69"
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

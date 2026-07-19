# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.23 / @SHA_*@ placeholders below with
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
  version "0.4.23"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.23/stella-0.4.23-aarch64-apple-darwin.tar.gz"
      sha256 "24a7626bc924fc868888064467f32cc06a1592351ac78893a9a917480503415a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.23/stella-0.4.23-x86_64-apple-darwin.tar.gz"
      sha256 "bfc10c7775c798fa4c2cde369c630eca3d64f38e80dbac814f3a446cf45b43f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.23/stella-0.4.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08fc3288817571493a6c34013f632ba2c59935b35f6c11cb268bfabd5bfcdf72"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.23/stella-0.4.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "27ba33b383490eb8c72a27b5101b504da1043984143d3fafcf94dc80def676fb"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.19 / @SHA_*@ placeholders below with
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
  version "0.3.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.19/stella-0.3.19-aarch64-apple-darwin.tar.gz"
      sha256 "8572320b39c53ca7656e652b61f0e5d776823e2146903b8d8f6fba6671e0b26e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.19/stella-0.3.19-x86_64-apple-darwin.tar.gz"
      sha256 "b7841b33a7b1c00def0e42fe8ccbd1b23e94c1cce20a7321904702a0b8faaa5d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.19/stella-0.3.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cbd543d8fcc4f9ef16a6426acb189c32852a1bfa93ae7ede5003cc7d6a056b3a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.19/stella-0.3.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9343959b86a02a889be76bf314869a0e0d456a56bf43d55801a268c51822521a"
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

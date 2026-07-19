# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.21 / @SHA_*@ placeholders below with
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
  version "0.4.21"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.21/stella-0.4.21-aarch64-apple-darwin.tar.gz"
      sha256 "9be05e03fc930acb8e42ce7bf062ee8cf4aa9f307533f76908b33762dba24030"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.21/stella-0.4.21-x86_64-apple-darwin.tar.gz"
      sha256 "63a208c706179f068f68e73199df22c79efa9faa9f5e1a08881fbcb6ad606aeb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.21/stella-0.4.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cfc027e315370aabf81cc57121966af0e2ad72ee881f793061aefa07f73044df"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.21/stella-0.4.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "16012991722e8a0b0b6d7d2da569d994242840075b32a996bc23b50dda767d72"
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

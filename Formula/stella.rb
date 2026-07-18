# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.16 / @SHA_*@ placeholders below with
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
  version "0.3.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.16/stella-0.3.16-aarch64-apple-darwin.tar.gz"
      sha256 "13b13f30b524c7c172fbfb8f17a7b0fde9a05e2f608b3e02b207ab317e5c94ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.16/stella-0.3.16-x86_64-apple-darwin.tar.gz"
      sha256 "0b8e128cc48e31d9db971864abe34a6b69e8e7cc56962c3504fb4e4ddcc5d4ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.16/stella-0.3.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d6e8864aa6c9831a20b4877c396e975c65954d6c53ddbb18be9a53a13d28dc8c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.16/stella-0.3.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "79567d6b37f626e68c6ca73fc706f385569bf5ce1214139f851c1383da0a2b00"
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

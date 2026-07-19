# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.28 / @SHA_*@ placeholders below with
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
  version "0.4.28"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.28/stella-0.4.28-aarch64-apple-darwin.tar.gz"
      sha256 "2d488636258ae439a9aecd5040f1c7ea0b8e8b5fd4fe3404ffd9a16ab6d0d07a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.28/stella-0.4.28-x86_64-apple-darwin.tar.gz"
      sha256 "99ef430be1165acab76375cdfd467c4c53aa30ea3db231bdab102f0ebc50a1a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.28/stella-0.4.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "949779329c2718a2948f81f20252e6999d21b10c3fb243722b3aab030af802bf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.28/stella-0.4.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fcedf9b4549e364d6f747d8f2077bd5b66730ea385d9ba2a0cd2a4b919def5c"
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

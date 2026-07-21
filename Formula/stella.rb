# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.49 / @SHA_*@ placeholders below with
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
  version "0.4.49"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.49/stella-0.4.49-aarch64-apple-darwin.tar.gz"
      sha256 "d9cd1e3a35a260b7c770114199aa7a147dfefcf2207fc3626dba74989bf07134"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.49/stella-0.4.49-x86_64-apple-darwin.tar.gz"
      sha256 "c1177a0a983ddc6d7ef293fb41996bb34ba9f5af7dcb3041d84f283d1a3fa330"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.49/stella-0.4.49-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1913791b598f187a4c64586e7fdcf0475be9d9153f0982b510861453e81d86ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.49/stella-0.4.49-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aa2d6f7f03fd8aa57106a5b7e09f283ceff64f029aef44963e8d476bfcf4e9dd"
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

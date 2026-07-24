# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.1 / @SHA_*@ placeholders below with
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
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.1/stella-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "9ea45544c96efad2c39d454a46b10fd82c842fa075028a9f99e024fbf869af3f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.1/stella-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "664a92bb949426144a905774e6bed3842b69c6b04a1153edb299edf9dca67dd0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.1/stella-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b82e3ecb1ab1d874c195d3a924cb6e658bb813b8ef38980000a30f9acea96ff0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.1/stella-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9aae4fa5df5a4a668f69593a2e619e6da63d3619ad295d10d33c9b1e57a63f5"
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

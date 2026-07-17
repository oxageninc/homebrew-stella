# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.3 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-stella) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.3.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.3/stella-0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "10f58c75574ec90f4ee7cb520ae67bdd2fa4996938e9695beaec8787257c8c16"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.3/stella-0.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "29ec4743e77954afa527899696718b7d49d279617c00a195b6d13b2ed192b8cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.3/stella-0.3.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c2afb1cd706289b33089999bda4006cbfa29c4728736327f2c2ebd836aeaece"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.3/stella-0.3.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "948a3189ea75b21104f300bad657dc1ab454c87220096dcc847015ad86ac9713"
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

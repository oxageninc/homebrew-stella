# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.40 / @SHA_*@ placeholders below with
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
  version "0.4.40"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.40/stella-0.4.40-aarch64-apple-darwin.tar.gz"
      sha256 "f4d71ad5a3cc98fa210cb6e287acb9532b3495642f9a549b7224d0d25946fa15"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.40/stella-0.4.40-x86_64-apple-darwin.tar.gz"
      sha256 "745626d1f95b710abae07740aa81c9361fd5e48e735d98cf8293bfe5253f887c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.40/stella-0.4.40-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73365ffe8610819fdb569e96cd9fbeed55824c5f01463f7c4b9bc7e99d7a2fef"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.40/stella-0.4.40-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c5ae0fc4c540cf2926497bd30a49f3341aa546f9b62b86c2e3ba86ffd7fd3732"
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

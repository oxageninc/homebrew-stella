# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.47 / @SHA_*@ placeholders below with
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
  version "0.4.47"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.47/stella-0.4.47-aarch64-apple-darwin.tar.gz"
      sha256 "a02e58d6abdaf9006995a879bb18fee59fb582e882733a83fc1764562e7105c9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.47/stella-0.4.47-x86_64-apple-darwin.tar.gz"
      sha256 "16195a74a8894a91cc77b632334b9b088d0727a02af454301d80158286da960d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.47/stella-0.4.47-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d9bc84a795bee53cbbb20ce03171ba5da6c1867771106781e68102bb059f603"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.47/stella-0.4.47-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ca8a037185b6b192a1c0a41b725da4e8de927ec359e9d419c89932f380f4c68"
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

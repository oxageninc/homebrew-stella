# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.14 / @SHA_*@ placeholders below with
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
  version "0.4.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.14/stella-0.4.14-aarch64-apple-darwin.tar.gz"
      sha256 "a612967d745a1efe8166ca58704635e25b6cf188b55f3516a527820514ac5f96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.14/stella-0.4.14-x86_64-apple-darwin.tar.gz"
      sha256 "f5a3505d6d3877604ad2e73dc848638667ccb4fe3ce2f05538ad949d8f2170b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.14/stella-0.4.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee78625c6a669f187c344973075e318ec6f5de762981720f34f276ca78b65b26"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.14/stella-0.4.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f932dc9cf218a4027cb2df291e5516449b2b41068860f797a36d90c4bc95f419"
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

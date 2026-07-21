# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.53 / @SHA_*@ placeholders below with
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
  version "0.4.53"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.53/stella-0.4.53-aarch64-apple-darwin.tar.gz"
      sha256 "c80bbfc05d819db0065c254682c490f075113157cbe98c6e1d757cac011afd5f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.53/stella-0.4.53-x86_64-apple-darwin.tar.gz"
      sha256 "941f210d7853be3c206c5ed3bd89f0aaa2b8efea770d81b2427a65053b4ea123"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.53/stella-0.4.53-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "854840064ddd5d1c805aea9ec6541cfb6d671518774c895a231c1c635e3cbce5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.53/stella-0.4.53-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e1dfd2f1c9e98641978b3b3b935e6eef1ca385a7d0d912972315ace3fed5b2c"
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

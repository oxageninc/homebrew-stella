# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.9 / @SHA_*@ placeholders below with
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
  version "0.5.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.9/stella-0.5.9-aarch64-apple-darwin.tar.gz"
      sha256 "b0bae419cc857950d29ed2d32de6cf816ae324e1cbb23612b8c05ecc8dca1a51"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.9/stella-0.5.9-x86_64-apple-darwin.tar.gz"
      sha256 "72962bc3d9661ba521c6bbe583dc3342cf9d3c9d298ce881e2a9c30f98b2840e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.9/stella-0.5.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26f61d37cc07d9e16324bf8cbc789025314cf82f160f53bbc642d94e67f21945"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.9/stella-0.5.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7d0c29f51a06edcda5ffaac33d90022517fab46cf97bc27d8aab47a38de7021"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.8 / @SHA_*@ placeholders below with
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
  version "0.5.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.8/stella-0.5.8-aarch64-apple-darwin.tar.gz"
      sha256 "7cea1b6ccdf83878e54d2d5d66d93546258bf36ddab3e549d626453c7f424321"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.8/stella-0.5.8-x86_64-apple-darwin.tar.gz"
      sha256 "b0688b53d950df44a2e98bfe5dfc10d7e5b4df8c543210d9cae0d8435222bf33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.8/stella-0.5.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "030604f68e756a772877856e096b7630ed53c2d417b2fa9a734b14d3bfe79d4f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.8/stella-0.5.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "440fc00faae569f24360ef2d5c870ee629bdd2d1e100dcb56a14a51e7d22f561"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.16 / @SHA_*@ placeholders below with
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
  version "0.4.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.16/stella-0.4.16-aarch64-apple-darwin.tar.gz"
      sha256 "aba07e594296fed30222aaeccd1fd290e11db3f3fe3d70dfa65130819d2fdf34"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.16/stella-0.4.16-x86_64-apple-darwin.tar.gz"
      sha256 "8935ae4f2401dab2f747b73c8a735caa5d74119e919335d315f95ea63c003399"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.16/stella-0.4.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8190a9be92d90dc94429384d9d261b4bab8d879c6b0c73dce555692a69407478"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.16/stella-0.4.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f518aa3923ecc64975d0ee115cf2ce21d9f489895cc04d1317256e3db7c67e41"
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

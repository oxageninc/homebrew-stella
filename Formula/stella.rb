# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.17 / @SHA_*@ placeholders below with
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
  version "0.4.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.17/stella-0.4.17-aarch64-apple-darwin.tar.gz"
      sha256 "86df5c9e22f7d45f89ad4a38b501b7ba29f2989bc01693c95206afe1c830ef5a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.17/stella-0.4.17-x86_64-apple-darwin.tar.gz"
      sha256 "a6c7025bb9fe62c5bb495f160810843092528fa459a6ba3e1ef7d47136dfa091"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.17/stella-0.4.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "990164907167bcdfbc18fdfba696b42efb77b10aa48e0dae3ca5a32b171eed6c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.17/stella-0.4.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d531feccd5d1b774cece39591f07cf3ca08f7e1356602871161d2cf58e2cc226"
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

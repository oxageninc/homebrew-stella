# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.38 / @SHA_*@ placeholders below with
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
  version "0.4.38"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.38/stella-0.4.38-aarch64-apple-darwin.tar.gz"
      sha256 "fc2e3e0e1dd68b1490a203caf5ad2959949e4ce4c7ede928eb9f1ab44c9ef5c9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.38/stella-0.4.38-x86_64-apple-darwin.tar.gz"
      sha256 "9878c998fd0d4e37b7b1301427a1e5bdaa4eabc5aced44388666c74045960ae4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.38/stella-0.4.38-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee09d386a866e4a0206b34b19409cb005d892a0c3220182a4f2e97a0f7358555"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.38/stella-0.4.38-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a0dbd8b1fa41b179eef83ab44e2bb972ea8d235ebf00993d938fff21a58c41e"
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

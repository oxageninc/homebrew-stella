# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.4.27 / @SHA_*@ placeholders below with
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
  version "0.4.27"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.27/stella-0.4.27-aarch64-apple-darwin.tar.gz"
      sha256 "563245d8bf8e812c70e65fd7d3d06395addde953aebeade0be63497d17b89ed3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.27/stella-0.4.27-x86_64-apple-darwin.tar.gz"
      sha256 "543d315a311455b1db4224c3d51597bab85c9137553f1a7be536d3728dc800b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.4.27/stella-0.4.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cfa34226f7d54cbd11e2664a674d579e2423b7c3fe1f33ef15ea3d018bdd0837"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.4.27/stella-0.4.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0133267ac4304c3d0820193f5c3a6d20f2f76c54634f1c734be64ca0debea535"
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

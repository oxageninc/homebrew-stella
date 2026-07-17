# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.3.7 / @SHA_*@ placeholders below with
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
  version "0.3.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.7/stella-0.3.7-aarch64-apple-darwin.tar.gz"
      sha256 "3d2beb7683acd095e3318926a50f0064cb99836f408dbbd7a08dcb63a4226650"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.7/stella-0.3.7-x86_64-apple-darwin.tar.gz"
      sha256 "4ca6ba998e357e0f2904424eb5ba9424766973b694a2b5a8cfc3206ec73f4168"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.3.7/stella-0.3.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6de3ca17fa9b7c218a32cb7c748b53781aa64ce9a7056ad18a0087f1d29791c0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.3.7/stella-0.3.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ac21bab5dbafb2838e9da62cf83c875fc36e5b02810e3e5bca6b03167ba8d4a"
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

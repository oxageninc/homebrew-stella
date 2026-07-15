# Homebrew formula for the Stella CLI.
#
# This formula installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/oxageninc/stella"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.1/stella-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "121c5b1036fd0b09497e00dc148a36296cb0fd9d92dcbb13fce335cc1ae8cb90"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.1/stella-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "TODO_x86_64_darwin_sha256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.1/stella-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "TODO_aarch64_linux_sha256"
    end
    on_intel do
      url "https://github.com/oxageninc/stella/releases/download/v0.2.1/stella-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "TODO_x86_64_linux_sha256"
    end
  end

  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end

class Shpool < Formula
  desc "Lightweight persistent shell session manager"
  homepage "https://github.com/shell-pool/shpool"
  url "https://github.com/shell-pool/shpool/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "7b2a050fa33139cc49b5345dbf66936d8589f6b152939d811e9336754cbd9145"
  license "Apache-2.0"
  head "https://github.com/shell-pool/shpool.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install",
      "--locked",
      "--root", prefix,
      "--path", "shpool"
  end

  service do
    run [opt_bin/"shpool", "daemon"]
    keep_alive true
    log_path var/"log/shpool.log"
    error_log_path var/"log/shpool.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shpool version")
  end
end

# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class PodmanMacNetConnect < Formula
  desc "Connect directly to Podman for macOS containers via IP address 🐳 💻"
  homepage "https://github.com/jasonmadigan/podman-mac-net-connect"
  version "v0.0.1"
  url "https://github.com/jasonmadigan/podman-mac-net-connect/archive/refs/tags/#{version}.tar.gz"
  sha256 "ab0433a9e3ee63da69adeab3897e86559ce11906381e9a6017b08fe79036e68b"
  license "MIT"

  depends_on "go" => :build

  def install
    if ENV["HOMEBREW_GOPROXY"]
      ENV["GOPROXY"] = ENV["HOMEBREW_GOPROXY"]
    end

    system "make", "VERSION=#{version}", "build-go"
    
    bin.install Dir["*"]
  end

  service do
    keep_alive true
    run opt_bin/"podman-mac-net-connect"
    log_path var/"log/podman-mac-net-connect/std_out.log"
    error_log_path var/"log/podman-mac-net-connect/std_error.log"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test podman-mac-net-connect`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

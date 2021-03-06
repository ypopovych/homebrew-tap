class Libevhtp < Formula
  desc "A more flexible replacement for libevent's http API"
  homepage 'http://ellzey.github.io/libevhtp/'
  version '1.2.11n'

  url "https://github.com/ellzey/libevhtp/archive/#{version}.tar.gz"

  sha256 'ae114300659267c7e5f9805ba15f7e3f3461613371f38e3f84520a1703146afd'

  head 'https://github.com/ellzey/libevhtp.git'

  depends_on 'cmake' => :build
  depends_on 'libevent'

  depends_on 'openssl' => :recommended
  depends_on 'oniguruma' => :recommended
  depends_on 'jemalloc' => :optional

  option "without-oniguruma", "Disable regex support"
  option "without-evthr", "Disable evthread support"
  option "with-shared", "Build shared library too"

  def install
    args = ["."]

    args << "-DEVHTP_DISABLE_SSL:STRING=ON" if build.without? "openssl"
    args << "-DEVHTP_DISABLE_REGEX:STRING=ON" if build.without? "oniguruma"
    args << "-DEVHTP_DISABLE_EVTHR:STRING=ON" if build.without? "evthr"

    args << "-DEVHTP_BUILD_SHARED:STRING=ON" if build.with? "shared"
    args << "-DEVHTP_USE_JEMALLOC:STRING=ON" if build.with? "jemalloc"

    system "cmake", *args, *std_cmake_args
    system "make install"
  end
end

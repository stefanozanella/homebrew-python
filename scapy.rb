require 'formula'

class Scapy < Formula
  homepage 'http://www.secdev.org/projects/scapy/'
  url 'http://www.secdev.org/projects/scapy/files/scapy-2.2.0.tar.gz'
  sha1 'ae0a9947a08a01a84abde9db12fed074ac888e47'

  depends_on :python
  depends_on 'libdnet' => 'with-python'
  depends_on 'pypcap'
  depends_on LanguageModuleDependency.new(:python, 'gnuplot-py', 'Gnuplot')
  depends_on LanguageModuleDependency.new(:python, 'pyx==0.12.1', 'pyx')
  depends_on 'pycrypto' => :python

  def install
    system "python", 'setup.py', 'install', "--prefix=#{prefix}"
  end
end

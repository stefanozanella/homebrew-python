require 'formula'

class Pillow < Formula
  homepage 'https://github.com/python-imaging/Pillow'
  url 'https://github.com/python-imaging/Pillow/archive/2.1.0.tar.gz'
  sha1 'e948dbfd4902de3dbf8bbc9556033f76ce906a7f'
  head 'https://github.com/python-imaging/Pillow.git'

  depends_on :python => :recommended
  depends_on 'little-cms'
  depends_on 'graphicsmagick'
  depends_on 'freetype'
  depends_on 'jpeg'
  depends_on 'libtiff'

  def install
    # Help pillow find zlib and little-cms (Note freetype2 is detected correctly)
    inreplace "setup.py" do |s|
      s.gsub! "ZLIB_ROOT = None", "ZLIB_ROOT = ('#{MacOS.sdk_path}/usr/lib', '#{MacOS.sdk_path}/usr/include')" unless MacOS::CLT.installed?
      s.gsub! "LCMS_ROOT = None", "LCMS_ROOT = ('#{Formula.factory('littlecms').opt_prefix}/lib', '#{Formula.factory('littlecms').opt_prefix}/include')"
      s.gsub! "JPEG_ROOT = None", "JPEG_ROOT = ('#{Formula.factory('jpeg').opt_prefix}/lib', '#{Formula.factory('jpeg').opt_prefix}/include')"
      s.gsub! "TIFF_ROOT = None", "TIFF_ROOT = ('#{Formula.factory('libtiff').opt_prefix}/lib', '#{Formula.factory('libtiff').opt_prefix}/include')"
      s.gsub! "FREETYPE_ROOT = None", "FREETYPE_ROOT = ('#{Formula.factory('freetype').opt_prefix}/lib', '#{Formula.factory('freetype').opt_prefix}/include')"
    end

    system "python", "setup.py", "install", "--prefix=#{prefix}", "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    # Only a small test until https://github.com/python-imaging/Pillow/issues/17
    system "python", "-c", "import PIL.Image"
  end
end

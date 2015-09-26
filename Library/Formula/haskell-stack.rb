require "language/haskell"

class HaskellStack < Formula
  include Language::Haskell::Cabal

  desc "The Haskell Tool Stack"
  homepage "https://www.stackage.org"
  url "https://github.com/commercialhaskell/stack/archive/v0.1.5.0.tar.gz"
  sha256 "2e32a0ac6a7e2a602eb039298925097141d00149119b2aa490a083b02a2002e2"

  head "https://github.com/commercialhaskell/stack.git"

  bottle do
    sha256 "cb28bda6f3aae15015f5fcf58b1ef36655a609542da709fb51ce8138440fa341" => :yosemite
    sha256 "ca459d7260b5092be38c2a395d5dd5f248b6f9020ab2f3c5032a29ad7754ebb5" => :mavericks
    sha256 "d538c8a32841c5f6203297c8b8b059f2e98a01ba82e9c353a24194952f19d203" => :mountain_lion
  end

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "pcre"

  setup_ghc_compilers

  def install
    cabal_sandbox do
      cabal_install "--only-dependencies"
      cabal_install "--prefix=#{prefix}"
    end
    cabal_clean_lib
  end

  test do
    system "#{bin}/stack", "new", "test"
  end
end

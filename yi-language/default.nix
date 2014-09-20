{ cabal, alex, binary, dataDefault, derive, hashable, hspec, lens
, ooPrototypes, pointedlist, QuickCheck, regexBase, regexTdfa
, transformersBase, unorderedContainers
}:

let pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  file = builtins.readFile /home/bmuk/Code/yi-language/yi-language.cabal;
  strs = lib.strings.splitString "\n" file;
  vstr = builtins.head (builtins.filter (s: lib.strings.hasPrefix "version:" s) strs);
  vrsn = lib.strings.removePrefix "version:" (lib.strings.replaceChars [" "] [""] vstr);

in
cabal.mkDerivation (self: {
  pname = "yi-language";
  version = vrsn;
  src = /home/bmuk/Code/yi-language;
  buildDepends = [
    binary dataDefault derive hashable lens ooPrototypes pointedlist
    regexBase regexTdfa transformersBase unorderedContainers
  ];
  testDepends = [
    binary dataDefault derive hashable hspec lens pointedlist
    QuickCheck regexBase regexTdfa transformersBase unorderedContainers
  ];
  buildTools = [ alex ];
  meta = {
    homepage = "https://github.com/yi-editor/yi-language";
    description = "Collection of language-related Yi libraries";
    license = self.stdenv.lib.licenses.gpl2;
    platforms = self.ghc.meta.platforms;
  };
})

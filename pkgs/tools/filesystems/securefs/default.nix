{ lib, stdenv, fetchFromGitHub
, cmake
, fuse }:

stdenv.mkDerivation rec {
  pname = "securefs";
  version = "0.13.0";

  src = fetchFromGitHub {
    sha256 = "sha256-P0PvzmafJmcV2zA7poYWyDLP65oflvuFZwK8XxjDBJM=";
    rev = version;
    repo = "securefs";
    owner = "netheril96";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fuse ];

  meta = with lib; {
    inherit (src.meta) homepage;
    description = "Transparent encryption filesystem";
    longDescription = ''
      Securefs is a filesystem in userspace (FUSE) that transparently encrypts
      and authenticates data stored. It is particularly designed to secure
      data stored in the cloud.
      Securefs mounts a regular directory onto a mount point. The mount point
      appears as a regular filesystem, where one can read/write/create files,
      directories and symbolic links. The underlying directory will be
      automatically updated to contain the encrypted and authenticated
      contents.
    '';
    license = with licenses; [ bsd2 mit ];
    platforms = platforms.unix;
  };
}

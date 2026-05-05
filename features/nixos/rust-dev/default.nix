# System dependencies for Rust development.
# (User-side rustup/cargo come from features/shared/default.nix's home.packages.)
{
  system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      glib
      glibc
      gcc
      pkg-config
      clang
      llvmPackages.bintools
      llvmPackages.stdenv
      libiconv
      openssl
      openssl.dev
      perl
    ];
  };
}

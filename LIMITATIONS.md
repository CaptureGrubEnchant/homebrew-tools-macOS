# Limitations

## Package Availability

Homebrew is installed through the upstream installer or package installer rather than through
platform package repositories. The supported default prefixes are:

* Apple Silicon macOS: `/opt/homebrew`
* Intel macOS: `/usr/local`
* Linux: `/home/linuxbrew/.linuxbrew`

### macOS

Homebrew currently supports Apple Silicon and 64-bit Intel macOS systems running a supported
macOS release on official Apple hardware. The default prefix is required for the most reliable
binary package, or bottle, support.

This cookbook currently supports `mac_os_x` only and assumes the macOS Homebrew prefixes above.

### Linux

Homebrew can be used on Linux and WSL 2, but this cookbook does not currently declare Linux
platform support. A Linux expansion would need separate resource behavior for the
`/home/linuxbrew/.linuxbrew` prefix, build-tool prerequisites, and Linux-specific test coverage.

## Architecture Limitations

* macOS: Apple Silicon and Intel x86_64 are supported by Homebrew.
* Linux: ARM64/AArch64 and Intel x86_64 with SSSE3 support are Tier 1 when the rest of the
  Linux support requirements are met.
* 32-bit x86 is unsupported by Homebrew.
* 32-bit ARM is Tier 3 and has no bottle support.

## Source/Compiled Installation

Homebrew supports binary packages when installed in the default prefix. Installing outside the
default prefix can force source builds and is unsupported by Homebrew for official packages.

### Build Dependencies

| Platform Family | Packages |
| --- | --- |
| macOS | Xcode Command Line Tools |
| Debian/Ubuntu | build-essential, procps, curl, file, git |
| Fedora | development-tools, procps-ng, curl, file |
| CentOS Stream/RHEL | Development Tools, procps-ng, curl, file |
| Arch Linux | base-devel, procps-ng, curl, file, git |

## Known Issues

* Homebrew Cask is a macOS workflow; cask resources should not be used for Linux expansion without
  separate support evidence.
* The upstream one-line installer requires `/bin/bash`; alternate shells do not run the installer
  entrypoint directly.
* Multi-user shared Homebrew installations are unsupported by Homebrew.

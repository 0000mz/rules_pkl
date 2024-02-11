# Building pkl

## Prerequisite
- Install gradle v8+
- Install jdk 11

## Building
The executable definitions are defined in `pkl-cli/pkl-cli.gradle.kts`.
An executable build target is defined for each os and architecture:
- `gradle pkl-cli:linuxExecutableAmd64` for linux amd64 executable.
- `gradle pkg-cli:linuxExecutableAarch64` for linux aarch64 executable.
- Similar executable targets exist in the same file for mac and alpine.

If the build succeeds, the resulting `pkl` binary will be located in `pkl-cli/build/executalbe/pkl-<os>-<arch>`, i.e. for `pkg-cli:linuxExecutableAmd64`, the `pkl` executable will be `pkl-cli/build/executalbe/pkl-llinux-amd64`.
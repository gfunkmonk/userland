# Build System Updates - Out-of-Date Code Check

## Summary

This document summarizes the out-of-date code and build system problems identified and fixed in the userland repository.

## Issues Identified

### 1. Outdated CMake Version Requirement
**Problem:** All CMakeLists.txt files were using `cmake_minimum_required(VERSION 2.8)`, which is extremely outdated.
- CMake 2.8 was released in 2009 and has been deprecated for many years
- Current CMake version is 3.31.6
- CMake 3.10+ is the minimum recommended version to avoid deprecation warnings

**Impact:** 
- Compatibility issues with modern CMake installations
- Missing out on CMake improvements and features from the last 15+ years
- Deprecation warnings when building with modern CMake

**Fix:** Updated all CMakeLists.txt files to require CMake 3.10, which provides:
- Better cross-platform support
- Improved dependency handling
- Modern CMake features and policies
- No deprecation warnings with current CMake

### 2. Deprecated CMake Command Syntax
**Problem:** Many CMake files were using old-style capitalized commands:
- `SET()` instead of `set()`
- `ADD_DEFINITIONS()` instead of `add_definitions()`
- `INCLUDE()` instead of `include()`

**Impact:**
- Inconsistent code style
- Following outdated CMake conventions
- Harder to maintain and read

**Fix:** Modernized CMake syntax by:
- Converting all `SET()` to `set()`
- Converting all `ADD_DEFINITIONS()` to `add_definitions()`
- Converting all `INCLUDE()` to `include()`
- Made syntax consistent across all CMake files

### 3. Missing .gitignore Entries
**Problem:** CMake build artifacts were not properly excluded from version control

**Fix:** Added the following entries to .gitignore:
- `CMakeFiles/`
- `CMakeCache.txt`
- `cmake_install.cmake`

## Files Modified

### CMake Configuration Files
1. `/CMakeLists.txt` - Main build configuration
2. `/makefiles/cmake/vmcs.cmake` - VMCS package configuration
3. `/makefiles/cmake/toolchains/arm-linux-gnueabihf.cmake` - ARM toolchain
4. `/makefiles/cmake/toolchains/aarch64-linux-gnu.cmake` - ARM64 toolchain
5. `/makefiles/cmake/toolchains/bcm2708-glibc-linux.cmake` - BCM2708 toolchain

### Subdirectory CMakeLists.txt Files
6. `/interface/vcos/CMakeLists.txt`
7. `/interface/mmal/test/CMakeLists.txt`
8. `/middleware/openmaxil/CMakeLists.txt`
9. `/helpers/dtoverlay/CMakeLists.txt`
10. `/containers/CMakeLists.txt`
11. `/host_applications/android/apps/vidtex/CMakeLists.txt`
12. `/host_applications/linux/apps/dtmerge/CMakeLists.txt`
13. `/host_applications/linux/apps/gencmd/CMakeLists.txt`
14. `/host_applications/linux/apps/smem/CMakeLists.txt`
15. `/host_applications/linux/apps/dtoverlay/CMakeLists.txt`
16. `/host_applications/linux/apps/raspicam/CMakeLists.txt`

### Other Files
17. `.gitignore` - Added CMake build artifact exclusions

## Testing

The build system was tested with:
- CMake 3.31.6 (current version)
- Native build using `./buildme --native`
- All deprecation warnings have been eliminated

## Recommendations

### Further Improvements
While the current updates address the most critical outdated issues, consider these future enhancements:

1. **Update to CMake 3.12+** for better target-based configurations
2. **Replace add_definitions() with target_compile_definitions()** for better encapsulation
3. **Use modern CMake target properties** instead of global variables
4. **Add CTest integration** for better testing infrastructure
5. **Consider using FetchContent** for external dependencies instead of submodules

### Note on Repository Status
As stated in the README.md, this repository is deprecated and ancient. The Raspberry Pi project has moved to standard Linux APIs (V4L2, DRM/KMS, Mesa). Users should consider migrating away from this codebase to modern alternatives.

## Compatibility

These changes maintain backward compatibility with:
- CMake 3.10 and later
- All existing build scripts and toolchains
- All target platforms (ARM, ARM64, native)

No changes were made to:
- Source code (.c, .cpp, .h files)
- Build scripts (buildme)
- Runtime behavior
- API interfaces

## Conclusion

The build system has been modernized to work properly with contemporary CMake versions while maintaining compatibility with the existing codebase. All CMake deprecation warnings have been eliminated, and the build configuration now follows modern CMake best practices.

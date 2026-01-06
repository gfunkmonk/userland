
#
# CMake defines to cross-compile to ARM/Linux on BCM2708 using glibc.
#

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER bcm2708-gcc)
set(CMAKE_CXX_COMPILER bcm2708-g++)
set(CMAKE_ASM_COMPILER bcm2708-gcc)
set(CMAKE_SYSTEM_PROCESSOR arm)

add_definitions("-march=armv6")

# rdynamic means the backtrace should work
IF (CMAKE_BUILD_TYPE MATCHES "Debug")
   add_definitions(-rdynamic)
ENDIF()

# avoids annoying and pointless warnings from gcc
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -U_FORTIFY_SOURCE")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -c")

include(FetchContent)

# Fetch the WASI toolchain from Github
FetchContent_Declare(
  wasi_sdk_toolchain
  SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/wasi-sdk"
  GIT_REPOSITORY https://github.com/rioam2/wasi-sdk-toolchain.git
  GIT_TAG 2bea7d9c74b58fbd09836e4824f4aad99f591930
)
FetchContent_MakeAvailable(wasi_sdk_toolchain)

# Source toolchain file(s)
include("${wasi_sdk_toolchain_SOURCE_DIR}/wasi-sdk.toolchain.cmake")

# Initialize a specific version of the WASI toolchain
initialize_wasi_toolchain(
  WIT_BINDGEN_TAG "v0.43.0"
  WASMTIME_TAG "v35.0.0"
  WASM_TOOLS_TAG "v1.236.0"
  WASI_SDK_TAG "wasi-sdk-27"
  TARGET_TRIPLET "wasm32-wasip1"
  ENABLE_EXPERIMENTAL_STUBS ON
)

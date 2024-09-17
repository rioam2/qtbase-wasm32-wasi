include(FetchContent)

FetchContent_Declare(
  wasi_sdk_toolchain
  SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/wasi-sdk"
  GIT_REPOSITORY https://github.com/rioam2/wasi-sdk-toolchain.git
  GIT_TAG rioam2/enable-sjlj-support
)
FetchContent_MakeAvailable(wasi_sdk_toolchain)

include("${wasi_sdk_toolchain_SOURCE_DIR}/wasi-sdk.toolchain.cmake")

initialize_wasi_toolchain(
  WIT_BINDGEN_TAG "v0.43.0"
  WASMTIME_TAG "v35.0.0"
  WASM_TOOLS_TAG "v1.236.0"
  WASI_SDK_TAG "wasi-sdk-29"
  TARGET_TRIPLET "wasm32-wasip1"
  ENABLE_EXPERIMENTAL_STUBS ON
)

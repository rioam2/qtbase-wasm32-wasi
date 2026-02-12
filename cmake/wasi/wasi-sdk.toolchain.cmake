include(FetchContent)

FetchContent_Declare(
  wasi_sdk_toolchain
  SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/wasi-sdk"
  GIT_REPOSITORY https://github.com/rioam2/wasi-sdk-toolchain.git
  GIT_TAG 82e802469d9eaf5cac64c09ca31f182c4673aa37
)
FetchContent_MakeAvailable(wasi_sdk_toolchain)

include("${wasi_sdk_toolchain_SOURCE_DIR}/wasi-sdk.toolchain.cmake")

initialize_wasi_toolchain(
  WIT_BINDGEN_TAG "v0.53.1"
  WASMTIME_TAG "v41.0.3"
  WASM_TOOLS_TAG "v1.245.1"
  WASI_SDK_TAG "wasi-sdk-30"
  TARGET_TRIPLET "wasm32-wasi"
  ENABLE_EXPERIMENTAL_SETJMP ON
  ENABLE_EXPERIMENTAL_STUBS ON
)

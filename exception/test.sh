# 1. ndk r26d / ndk r27d
# 2. odr_test(c++_static) link libodr_shared.so(c++_shared)
# 3. libodr_shared.so call stream operator

SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(realpath "${SCRIPT_DIR}")
BUILD_DIR="${PROJECT_DIR}/build"

rm -r ${BUILD_DIR}

ANDROID_NDK_ROOT="/media/leyougavin/1/tools/ndk/android-ndk-r26d"
cmake -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake" \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=latest \
      -DANDROID_STL=c++_static \
      -S "${PROJECT_DIR}" \
      -B "${BUILD_DIR}"

cmake --build "${BUILD_DIR}" -j$(nproc)

DEVICE_PATH=/data/local/tmp/odr
adb shell rm -r ${DEVICE_PATH}
adb shell mkdir -p ${DEVICE_PATH}
adb push "${BUILD_DIR}/shared/src/shared_demo-build/libodr_shared.so" ${DEVICE_PATH}
adb push "${BUILD_DIR}/odr_test" ${DEVICE_PATH}

adb shell "cd ${DEVICE_PATH} && export LD_LIBRARY_PATH=./ && chmod +x odr_test && ./odr_test"

rm -r ${BUILD_DIR}

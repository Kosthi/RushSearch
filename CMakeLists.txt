cmake_minimum_required(VERSION 3.5)
project(glass LANGUAGES CXX)

add_library(glass INTERFACE)
target_include_directories(glass INTERFACE .)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (APPLE)
    set(CMAKE_CXX_FLAGS "-Wall -Wextra -O3 -fpic -fno-exceptions -fno-rtti")
    find_package(OpenMP REQUIRED)
    target_link_libraries(glass INTERFACE OpenMP::OpenMP_CXX)
else ()
    # Linux 配置（保留原选项）
    set(CMAKE_CXX_FLAGS "-Wall -Wextra -O3 -lrt -fpic -fopenmp -ftree-vectorize -fno-exceptions -fno-rtti")
    # 添加 -march=native（仅限非 Apple 平台）
    if (NOT CMAKE_SYSTEM_PROCESSOR MATCHES "arm")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
    endif ()
endif ()

# 处理不同平台的链接库差异
if (UNIX AND NOT APPLE)
    # Linux 链接 librt
    target_link_libraries(glass INTERFACE rt)
endif ()

add_executable(main examples/main.cc)
target_link_libraries(main glass)

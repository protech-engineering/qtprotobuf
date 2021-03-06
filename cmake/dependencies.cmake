set(QT_PROTOBUF_INSTALL TRUE)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/grpc/CMakeLists.txt")
    message(STATUS "Found gRPC sub-project. Perform all-in-one build.")
    set(QT_PROTOBUF_INSTALL FALSE)

    set(gRPC_BUILD_TESTS FALSE)
    set(protobuf_BUILD_TESTS FALSE)
    add_subdirectory("3rdparty/grpc" EXCLUDE_FROM_ALL)
    if(TARGET grpc AND TARGET grpc++ AND TARGET grpc_cpp_plugin)
        add_library(gRPC::grpc ALIAS grpc)
        add_library(gRPC::grpc++ ALIAS grpc++)
        add_executable(gRPC::grpc_cpp_plugin ALIAS grpc_cpp_plugin)
        if (QT_PROTOBUF_NATIVE_GRPC_CHANNEL)
            export(TARGETS grpc++ grpc gpr NAMESPACE gRPC:: FILE gRPCTargets.cmake)
            export(TARGETS ssl crypto zlibstatic c-ares address_sorting FILE gRPCDepsTargets.cmake)
        endif()
        set(gRPC_FOUND TRUE)
    endif()
else()
    include("${QT_PROTOBUF_CMAKE_DIR}/ProtobufLookup.cmake")
    include("${QT_PROTOBUF_CMAKE_DIR}/gRPCLookup.cmake")
endif()

if(NOT "${QT_PROTOBUF_SOURCE_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
    message(STATUS "QtProtobuf configured as sub-project.")
    set(QT_PROTOBUF_INSTALL FALSE)
endif()

if(NOT QT_PROTOBUF_INSTALL)
    message(STATUS "All install rules are disabled.")
endif()

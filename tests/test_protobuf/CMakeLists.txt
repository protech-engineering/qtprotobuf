set(TARGET qtprotobuf_test)

include(${QT_PROTOBUF_CMAKE_DIR}/QtProtobufTest.cmake)

file(GLOB SOURCES
    simpletest.cpp
    serializationtest.cpp
    deserializationtest.cpp
    serializationcomplexmessagemap.cpp
    converterstest.cpp
    jsonserializationtest.cpp
    jsondeserializationtest.cpp
    duplicatedmetatypestest.cpp
    nestedtest.cpp)
if(NOT WIN32)
    list(APPEND SOURCES internalstest.cpp)
endif()

add_test_target(TARGET ${TARGET}
    SOURCES ${SOURCES}
    QML FIELDENUM)
add_target_windeployqt(TARGET ${TARGET}
    QML_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME ${TARGET} COMMAND ${TARGET})

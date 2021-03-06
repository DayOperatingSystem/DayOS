set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/CMake/DayOS.cmake)

project(DayOSFull)
cmake_minimum_required(VERSION 3.3)

set(DAYOS_KERNEL_INCLUDE ${CMAKE_SOURCE_DIR}/modules/Kernel/sys)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/image)

message("Executable output to " ${EXECUTABLE_OUTPUT_PATH})
set(RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})
#set(RUNTIME_OUTPUT_DIRECTORY "")

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${EXECUTABLE_OUTPUT_PATH}")
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${EXECUTABLE_OUTPUT_PATH}")
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${EXECUTABLE_OUTPUT_PATH}")
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${EXECUTABLE_OUTPUT_PATH}")

#SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_DIRECTORY}")
#SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_DIRECTORY}")

set(DRIVERKIT_INCLUDE "${CMAKE_SOURCE_DIR}/modules/Libraries/driverkit/include")
set(LIBDAYOS_INCLUDE "${CMAKE_SOURCE_DIR}/modules/Libraries/libdayos/include/dayos" "${CMAKE_SOURCE_DIR}/modules/Libraries/libdayos/include" "${CMAKE_SOURCE_DIR}/modules/Kernel/sys")
set(DOXYGEN_SOURCEDIRS "${CMAKE_SOURCE_DIR}/modules/Libraries/driverkit/include ${CMAKE_SOURCE_DIR}/modules/Libraries/libdayos/include/dayos ${CMAKE_SOURCE_DIR}/modules/Libraries/libdayos/include ${CMAKE_SOURCE_DIR}/modules/Kernel/sys")

find_package(Doxygen)
if(DOXYGEN_FOUND)
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/documentation/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
  add_custom_target(doc
	${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	COMMENT "Generating API documentation with Doxygen" VERBATIM
  )
endif(DOXYGEN_FOUND)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32 -Wall -g -fstack-protector-all -nostdinc -nostdlib -pedantic-errors")
set(CMAKE_ASM_FLAGS "-m32 -Wall -g -pedantic-errors")

add_subdirectory(modules)

add_custom_target(qemu-all COMMAND make VERBOSE=1 -C ${CMAKE_BINARY_DIR})
add_custom_target(qemu-image COMMAND sh ${CMAKE_SOURCE_DIR}/scripts/test-stdio-hd-external.sh ${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR} WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_dependencies(qemu-image qemu-all)

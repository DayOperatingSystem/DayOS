
set(TESTSUITE_SRC ${CMAKE_CURRENT_SOURCE_DIR}/testsuite/tests.cpp)
set(TESTSUITE_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/testsuite)
 
add_subdirectory(Libraries)
add_subdirectory(Base)
add_subdirectory(Drivers)
add_subdirectory(Kernel)

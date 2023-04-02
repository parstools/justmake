CMAKE_MINIMUM_REQUIRED(VERSION 3.5)
PROJECT(parser)

SET (CMAKE_CXX_STANDARD 17)

set(ANTLR4CPP_JAR_LOCATION ${PROJECT_SOURCE_DIR}/thirdparty/antlr/antlr-4.12.0-complete.jar)
INCLUDE(cmake/ExternalAntlr4Cpp.cmake)
include_directories( thirdparty/cpp_runtime/runtime/src )
link_directories( thirdparty/cpp_runtime/dist )
message(STATUS "Found antlr4cpp libs: ${ANTLR4CPP_LIBS} and includes: ${ANTLR4CPP_INCLUDE_DIRS} ")

function(get_arguments_jm ARGS)
    set(VAR jm_parser
            ${CMAKE_CURRENT_SOURCE_DIR}/JustmakeLexer.g4
            ${CMAKE_CURRENT_SOURCE_DIR}/JustmakeParser.g4)
    return_(${VAR})
endfunction()

fun_expr(generated_files_jm_space antlr4cpp_process_grammar(get_arguments_jm()))
separate_arguments(generated_files_jm UNIX_COMMAND ${generated_files_jm_space})

MESSAGE(WARNING "tutaj ${generated_files_jm}")
add_executable(jm_parser jm_driver.cpp ${generated_files_jm})
target_include_directories(jm_parser PRIVATE ${CMAKE_BINARY_DIR}/gen/jm_parser)
add_dependencies(jm_parser gen_jm_parser)
target_link_libraries(jm_parser antlr4-runtime)

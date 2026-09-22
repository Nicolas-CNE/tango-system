#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "yyjson::yyjson" for configuration "None"
set_property(TARGET yyjson::yyjson APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(yyjson::yyjson PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libyyjson.so.0.13.0"
  IMPORTED_SONAME_NONE "libyyjson.so.0"
  )

list(APPEND _cmake_import_check_targets yyjson::yyjson )
list(APPEND _cmake_import_check_files_for_yyjson::yyjson "${_IMPORT_PREFIX}/lib/libyyjson.so.0.13.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

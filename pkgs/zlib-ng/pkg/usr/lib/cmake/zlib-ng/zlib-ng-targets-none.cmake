#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "zlib-ng::zlib" for configuration "None"
set_property(TARGET zlib-ng::zlib APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(zlib-ng::zlib PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libz-ng.so.2.3.3"
  IMPORTED_SONAME_NONE "libz-ng.so.2"
  )

list(APPEND _cmake_import_check_targets zlib-ng::zlib )
list(APPEND _cmake_import_check_files_for_zlib-ng::zlib "${_IMPORT_PREFIX}/lib/libz-ng.so.2.3.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

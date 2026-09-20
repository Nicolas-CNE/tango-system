#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "WebP::sharpyuv" for configuration "None"
set_property(TARGET WebP::sharpyuv APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(WebP::sharpyuv PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libsharpyuv.so.0.0.1"
  IMPORTED_SONAME_NONE "libsharpyuv.so.0"
  )

list(APPEND _cmake_import_check_targets WebP::sharpyuv )
list(APPEND _cmake_import_check_files_for_WebP::sharpyuv "${_IMPORT_PREFIX}/lib/libsharpyuv.so.0.0.1" )

# Import target "WebP::webpdecoder" for configuration "None"
set_property(TARGET WebP::webpdecoder APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(WebP::webpdecoder PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libwebpdecoder.so.3.1.8"
  IMPORTED_SONAME_NONE "libwebpdecoder.so.3"
  )

list(APPEND _cmake_import_check_targets WebP::webpdecoder )
list(APPEND _cmake_import_check_files_for_WebP::webpdecoder "${_IMPORT_PREFIX}/lib/libwebpdecoder.so.3.1.8" )

# Import target "WebP::webp" for configuration "None"
set_property(TARGET WebP::webp APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(WebP::webp PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libwebp.so.7.1.8"
  IMPORTED_SONAME_NONE "libwebp.so.7"
  )

list(APPEND _cmake_import_check_targets WebP::webp )
list(APPEND _cmake_import_check_files_for_WebP::webp "${_IMPORT_PREFIX}/lib/libwebp.so.7.1.8" )

# Import target "WebP::webpdemux" for configuration "None"
set_property(TARGET WebP::webpdemux APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(WebP::webpdemux PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libwebpdemux.so.2.0.14"
  IMPORTED_SONAME_NONE "libwebpdemux.so.2"
  )

list(APPEND _cmake_import_check_targets WebP::webpdemux )
list(APPEND _cmake_import_check_files_for_WebP::webpdemux "${_IMPORT_PREFIX}/lib/libwebpdemux.so.2.0.14" )

# Import target "WebP::libwebpmux" for configuration "None"
set_property(TARGET WebP::libwebpmux APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(WebP::libwebpmux PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libwebpmux.so.3.0.13"
  IMPORTED_SONAME_NONE "libwebpmux.so.3"
  )

list(APPEND _cmake_import_check_targets WebP::libwebpmux )
list(APPEND _cmake_import_check_files_for_WebP::libwebpmux "${_IMPORT_PREFIX}/lib/libwebpmux.so.3.0.13" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

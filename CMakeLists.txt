project (komorebi)
cmake_minimum_required (VERSION 2.8)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/komorebi")
set (RELEASE_NAME "summit")
set (VERSION "0.9")
set (VERSION_INFO "Beta")
set (ARCHIVE_NAME komorebi-${VERSION})


find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 libgtop-2.0 glib-2.0>=2.38 gee-0.8)
add_definitions(${DEPS_CFLAGS})


link_directories(${DEPS_LIBRARY_DIRS})
find_package(Vala REQUIRED)
include(ValaVersion)
include(ValaPrecompile)


find_package(Vala REQUIRED)


ensure_vala_version("0.16" MINIMUM)
vala_precompile(VALA_C
    src/Main.vala

    src/OnScreen/BackgroundWindow.vala
    src/OnScreen/DateTimeBox.vala
    src/OnScreen/InfoBox.vala
    src/OnScreen/DesktopIcons.vala
    src/OnScreen/ResponsiveGrid.vala
    src/OnScreen/Icon.vala
    
    src/Utilities.vala

    src/OnScreen/PreferencesWindow.vala

PACKAGES
    gtk+-3.0
    glibtop
    gee-0.8
OPTIONS
    --vapidir=${CMAKE_CURRENT_SOURCE_DIR}/vapi/
   	--disable-warnings

)

add_definitions(${CFLAGS} -Wall -Winit-self -Wwrite-strings -Wunreachable-code -Wstrict-prototypes  )
add_executable(komorebi ${VALA_C})
target_link_libraries(komorebi ${DEPS_LIBRARIES} -lm)

install(TARGETS komorebi RUNTIME DESTINATION /System/Applications/)


######### Wallpapers ############
install(DIRECTORY data/Wallpapers/cloudy_forest/ DESTINATION /System/Resources/Komorebi/cloudy_forest)
install(DIRECTORY data/Wallpapers/dark_forest/ DESTINATION /System/Resources/Komorebi/dark_forest)
install(DIRECTORY data/Wallpapers/sunny_sand/ DESTINATION /System/Resources/Komorebi/sunny_sand)
install(DIRECTORY data/Wallpapers/foggy_sunny_mountain/ DESTINATION /System/Resources/Komorebi/foggy_sunny_mountain)
install(DIRECTORY data/Wallpapers/abstract_light_lines/ DESTINATION /System/Resources/Komorebi/abstract_light_lines)
install(DIRECTORY data/Wallpapers/city_lights/ DESTINATION /System/Resources/Komorebi/city_lights)
install(DIRECTORY data/Wallpapers/yosemite_cloudy/ DESTINATION /System/Resources/Komorebi/yosemite_cloudy)
install(DIRECTORY data/Wallpapers/day_night_mountain/ DESTINATION /System/Resources/Komorebi/day_night_mountain)
install(DIRECTORY data/Wallpapers/blue_pink_gradient/ DESTINATION /System/Resources/Komorebi/blue_pink_gradient)
install(DIRECTORY data/Wallpapers/dark_night_gradient/ DESTINATION /System/Resources/Komorebi/dark_night_gradient)
install(DIRECTORY data/Wallpapers/parallax_sky/ DESTINATION /System/Resources/Komorebi/parallax_sky)
install(DIRECTORY data/Wallpapers/parallax_man_mountain/ DESTINATION /System/Resources/Komorebi/parallax_man_mountain)
install(DIRECTORY data/Wallpapers/parallax_cartoon_mountain/ DESTINATION /System/Resources/Komorebi/parallax_cartoon_mountain)


######### Fonts ############
install(DIRECTORY data/Fonts/ DESTINATION /usr/share/fonts)

######### Icons ############
install(DIRECTORY data/Icons/ DESTINATION /System/Resources/Komorebi)

######### Other ############
install(FILES data/Other/komorebi.desktop DESTINATION /usr/share/applications/)
install(FILES data/Other/komorebi.desktop DESTINATION $ENV{HOME}/.config/autostart)

# Uninstall target
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

# Packaging configuration
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Komorebi - an awesome wallpapers manager for Linux")
set(CPACK_PACKAGE_VENDOR "")
set(CPACK_PACKAGE_CONTACT "Abraham Masri <imasrim114@gmail.com>")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR 0)
set(CPACK_PACKAGE_VERSION_MINOR 9)
set(CPACK_PACKAGE_VERSION_PATCH 2)
set(CPACK_PACKAGE_INSTALL_DIRECTORY "Komorebi")

set(CPACK_DEBIAN_PACKAGE_DEPENDS "libgtk-3-0 (>= 3.14), libglib2.0-0 (>= 2.38), libgtop2-common, libgee-0.8-dev")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64")
set(CPACK_DEBIAN_PACKAGE_SECTION "system")

include(CPack)
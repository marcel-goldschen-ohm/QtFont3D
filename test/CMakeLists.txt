# Created by Marcel Paz Goldschen-Ohm <marcel.goldschen@gmail.com>

# !!! Set env variable QT5_DIR to <Qt install prefix>/lib/cmake/Qt5
# For macx xcode project: cmake -G Xcode <dir of CMakeLists.txt>

cmake_minimum_required(VERSION 3.11)

set(PROJECT_NAME test_QtFont3D)
project(${PROJECT_NAME} LANGUAGES CXX)

# Fetch QtFont3D from GitHub.
# Files will be copied to local ${qtfont3d_SOURCE_DIR}.
# Building will only be done if the repository has a CMakeLists.txt file specifying build targets.
include(FetchContent)
FetchContent_Declare(QtFont3D
  GIT_REPOSITORY "https://github.com/marcel-goldschen-ohm/QtFont3D.git"
)
FetchContent_GetProperties(QtFont3D)
if(NOT qtfont3d_POPULATED)
  FetchContent_Populate(QtFont3D)
  message(STATUS "QtFont3D source dir: ${qtfont3d_SOURCE_DIR}")
  message(STATUS "QtFont3D binary dir: ${qtfont3d_BINARY_DIR}")
endif()

set(CMAKE_CXX_STANDARD 11) # This is equal to QMAKE_CXX_FLAGS += -std=c++0x
set(CMAKE_INCLUDE_CURRENT_DIR ON) # Search in current dir.
set(CMAKE_AUTOMOC ON) # Run moc automatically for Qt.
set(CMAKE_AUTOUIC ON) # Run uic automatically for *.ui files.
set(CMAKE_AUTORCC ON) # Run automatically for *.qrc files.

if(APPLE AND EXISTS /usr/local/opt/qt5)
  # Homebrew installs Qt5 (up to at least 5.9.1) in
  # /usr/local/qt5, ensure it can be found by CMake since
  # it is not in the default /usr/local prefix.
  list(APPEND CMAKE_PREFIX_PATH "/usr/local/opt/qt5")
endif()

# Find required packages.
find_package(Qt5 COMPONENTS Core Widgets OpenGL REQUIRED)
find_package(OpenGL REQUIRED)

# Build fetched QtFont3D as a static library.
add_library(QtFont3D STATIC ${qtfont3d_SOURCE_DIR}/QtFont3D.cpp ${qtfont3d_SOURCE_DIR}/QtFont3D.h)
qt5_use_modules(QtFont3D Widgets OpenGL)
target_link_libraries(QtFont3D ${QT_LIBRARIES} ${OPENGL_LIBRARIES})

# Build project executable.
add_executable(${PROJECT_NAME} test_QtFont3D.cpp test_QtFont3D.h)
target_include_directories(${PROJECT_NAME} PUBLIC ${qtfont3d_SOURCE_DIR})
qt5_use_modules(${PROJECT_NAME} Widgets OpenGL)
target_link_libraries(${PROJECT_NAME} ${QT_LIBRARIES} ${OPENGL_LIBRARIES} QtFont3D)
